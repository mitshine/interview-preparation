// Code your testbench here
// or browse Examples
class driver_callback extends uvm_callback; 
`uvm_object_utils(driver_callback) 
function new(string name = "driver_callback");
super.new(name); 
endfunction 
virtual task pre_drive; endtask 
virtual task post_drive; endtask 
endclass

class driver extends uvm_component; 
`uvm_component_utils(driver) 
`uvm_register_cb(driver,driver_callback) 
function new(string name, uvm_component parent); 
super.new(name,parent); 
endfunction 
task run_phase(uvm_phase phase); 
`uvm_do_callbacks(driver,driver_callback,pre_drive());
drive_pkt(); 
`uvm_do_callbacks(driver,driver_callback,post_drive()); 
endtask 
task drive_pkt(); 
`uvm_info("DRIVER","Inside drive_pkt method",UVM_LOW); 
endtask 
endclass

class user_callback extends driver_callback; 
`uvm_object_utils(user_callback) 
function new(string name = "user_callback"); 
super.new(name); 
endfunction 
task pre_drive; 
`uvm_info("USER_CALLBACK","Inside pre_drive method",UVM_LOW); 
endtask 
task post_drive; 
`uvm_info("USER_CALLBACK","Inside post_drive method",UVM_LOW); 
endtask 
endclass

class environment extends uvm_env; 
driver driv; 
`uvm_component_utils(environment) 
function new(string name, uvm_component parent); 
super.new(name,parent); 
endfunction 
function void build_phase(uvm_phase phase); 
super.build_phase(phase); 
driv = driver::type_id::create("driv", this); 
endfunction 
endclass

class basic_test extends uvm_test; 
environment env; 
`uvm_component_utils(basic_test) 
function new(string name = "basic_test", uvm_component parent=null); 
super.new(name,parent); 
endfunction 
function void build_phase(uvm_phase phase); 
super.build_phase(phase); 
env = environment::type_id::create("env", this); 
endfunction 
endclass

class user_callback_test extends basic_test; 
user_callback callback_1;
`uvm_component_utils(user_callback_test) 
function new(string name = "user_callback_test", uvm_component parent=null); 
super.new(name,parent); 
endfunction 
function void build_phase(uvm_phase phase); 
super.build_phase(phase); 
callback_1 = user_callback::type_id::create("callback_1", this); 
uvm_callbacks#(driver,driver_callback)::add(env.driv,callback_1); 
endfunction 
endclass

module tb; 
initial 
  run_test("basic_test"); 
endmodule 

OUTPUT:

UVM_INFO @ 0: reporter [RNTST] Running test basic_test...
UVM_INFO testbench.sv(24) @ 0: uvm_test_top.env.driv [DRIVER] Inside drive_pkt method
UVM_INFO /apps/vcsmx/vcs/U-2023.03-SP2//etc/uvm-1.2/src/base/uvm_report_server.svh(904) @ 0: reporter [UVM/REPORT/SERVER] 
--- UVM Report Summary ---

** Report counts by severity
UVM_INFO :    3
UVM_WARNING :    0
UVM_ERROR :    0
UVM_FATAL :    0
** Report counts by id
[DRIVER]     1
[RNTST]     1
[UVM/RELNOTES]     1

$finish called from file "/apps/vcsmx/vcs/U-2023.03-SP2//etc/uvm-1.2/src/base/uvm_root.svh", line 527.
$finish at simulation time                    0
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
CPU Time:      0.520 seconds;       Data structure size:   0.2Mb
Wed Jul  9 13:50:37 2025
