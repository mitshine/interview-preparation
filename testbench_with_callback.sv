// Code your testbench here
// or browse Examples
class driver extends uvm_component; 
`uvm_component_utils(driver) 
function new(string name, uvm_component parent); 
super.new(name,parent); 
endfunction 
task run_phase(uvm_phase phase);  
drive_pkt(); 
endtask 
task drive_pkt(); 
`uvm_info("DRIVER","Inside drive_pkt method",UVM_LOW); 
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
