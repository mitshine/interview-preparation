// With virtual sequence and virtual sequencer but without using p_senquencer handle 
// virtual sequence 
class virtual_seq extends uvm_sequence #(seq_item); 
core_A_seq Aseq; 
core_B_seq Bseq; 
core_A_sequencer seqr_A; 
core_B_sequencer seqr_B; 
`uvm_object_utils(virtual_seq) 
function new (string name = "virtual_seq"); 
super.new(name); 
endfunction 
task body(); 
env env_s; 
`uvm_info(get_type_name(), "virtual_seq: Inside Body", UVM_LOW); 
Aseq = core_A_seq::type_id::create("Aseq"); 
Bseq = core_B_seq::type_id::create("Bseq"); 
// virtual_sequencer is created in env, so we need env handle to find v_seqr. 
if(!$cast(env_s, uvm_top.find("uvm_test_top.env_o"))) `uvm_error(get_name(), "env_o is not found"); 
Aseq.start(env_s.v_seqr.seqr_A); 
Bseq.start(env_s.v_seqr.seqr_B); 
endtask 
endclass 

// virtual_sequencer 
class virtual_sequencer extends uvm_sequencer; 
`uvm_component_utils(virtual_sequencer) 
core_A_sequencer seqr_A; 
core_B_sequencer seqr_B; 
function new(string name = "virtual_sequencer", uvm_component parent = null); 
super.new(name, parent); 
endfunction 
endclass
