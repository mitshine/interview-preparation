// Code your testbench here
// or browse Examples
class my_monitor_cb extends uvm_callback; 
`uvm_object_utils(my_monitor_cb) 
function new(string name="my_monitor_cb"); 
super.new(name);
endfunction 
virtual function void call_pre_check(); 
// Placeholder 
endfunction 
virtual function void call_post_check(); 
// Placeholder 
endfunction 
endclass

class custom_monitor_cb extends my_monitor_cb; 
`uvm_object_utils(custom_monitor_cb) 
function new(string name="custom_monitor_cb"); 
super.new(name); 
endfunction 
// Override the callback method with custom behavior 
virtual function void call_pre_check(); 
`uvm_info(get_type_name(), $sformatf("[call_pre_check] start pre_check"), UVM_LOW) 
endfunction 
virtual function void call_post_check(); 
`uvm_info(get_type_name(), $sformatf("[call_post_check] start post_check"), UVM_LOW) 
endfunction
endclass

class my_monitor extends uvm_monitor; 
`uvm_component_utils(my_monitor) 
function new(string name="my_monitor", uvm_component parent=null); 
super.new(name, parent); 
endfunction 
// Register the callback class for this component 
`uvm_register_cb(my_monitor, my_monitor_cb) 
// Method that processes a transaction and uses the callback 
function void check_transaction(); 
// Call the registered callback(s) 
`uvm_do_callbacks(my_monitor, my_monitor_cb, call_pre_check()); 
// Normal checking logic 
`uvm_info("MONITOR", "Checking transaction", UVM_MEDIUM) 
// Or use a callback macro 
`uvm_do_callbacks(my_monitor, my_monitor_cb, call_post_check()); 
endfunction 
// Run phase where the transaction check happens 
virtual task run_phase(uvm_phase phase); 
super.run_phase(phase);
// Call the checking function, which triggers callbacks 
check_transaction(); 
endtask 
endclass 

class my_test extends uvm_test; 
`uvm_component_utils(my_test) 
function new(string name="my_test", uvm_component parent=null); 
super.new(name, parent); 
endfunction 
my_monitor          mon; 
custom_monitor_cb   my_cb; 
virtual function void build_phase(uvm_phase phase); 
super.build_phase(phase); 
// Create the monitor 
mon = my_monitor::type_id::create("mon", null); 
// Create and register the custom callback 
my_cb = custom_monitor_cb::type_id::create("my_cb"); 
uvm_callbacks#(my_monitor)::add(mon, my_cb); 
endfunction 
endclass

module tb; 
initial 
run_test("my_test"); 
endmodule 

OUTPUT:

UVM_INFO @ 0: reporter [RNTST] Running test my_test...
UVM_INFO testbench.sv(23) @ 0: reporter [custom_monitor_cb] [call_pre_check] start pre_check
UVM_INFO testbench.sv(42) @ 0: mon [MONITOR] Checking transaction
UVM_INFO testbench.sv(26) @ 0: reporter [custom_monitor_cb] [call_post_check] start post_check
UVM_INFO /apps/vcsmx/vcs/U-2023.03-SP2//etc/uvm-1.2/src/base/uvm_report_server.svh(904) @ 0: reporter [UVM/REPORT/SERVER] 
--- UVM Report Summary ---

** Report counts by severity
UVM_INFO :    5
UVM_WARNING :    0
UVM_ERROR :    0
UVM_FATAL :    0
** Report counts by id
[MONITOR]     1
[RNTST]     1
[UVM/RELNOTES]     1
[custom_monitor_cb]     2

$finish called from file "/apps/vcsmx/vcs/U-2023.03-SP2//etc/uvm-1.2/src/base/uvm_root.svh", line 527.
$finish at simulation time                    0
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
CPU Time:      0.510 seconds;       Data structure size:   0.2Mb
Wed Jul  9 13:44:13 2025
