// No Virtual Sequencer
class core_A_sequencer extends uvm_sequencer #(seq_item); 
`uvm_component_utils(core_A_sequencer) 
function new(string name = "core_A_sequencer", uvm_component parent = null); 
super.new(name, parent); 
endfunction 
endclass 
class core_B_sequencer extends uvm_sequencer #(seq_item); 
`uvm_component_utils(core_B_sequencer) 
function new(string name = "core_B_sequencer", uvm_component parent = null); 
super.new(name, parent); 
endfunction 
endclass 
// base_test 
class base_test extends uvm_test; 
env env_o; 
core_A_seq Aseq; 
core_B_seq Bseq; 
`uvm_component_utils(base_test) 
function new(string name = "base_test", uvm_component parent = null); 
super.new(name, parent);
endfunction 
function void build_phase(uvm_phase phase); 
super.build_phase(phase); 
env_o = env::type_id::create("env_o", this); 
endfunction 
task run_phase(uvm_phase phase); 
phase.raise_objection(this); 
Aseq = core_A_seq::type_id::create("Aseq"); 
Bseq = core_B_seq::type_id::create("Bseq"); 
Aseq.start(env_o.agt_A.seqr_A); 
Bseq.start(env_o.agt_B.seqr_B); 
phase.drop_objection(this); 
endtask 
endclass
