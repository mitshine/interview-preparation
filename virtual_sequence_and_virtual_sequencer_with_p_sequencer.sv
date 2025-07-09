// With virtual sequence and virtual sequencer using p_sequencer handle 
// Virtual sequence 
class virtual_seq extends uvm_sequence #(seq_item); 
core_A_seq Aseq; 
core_B_seq Bseq;   
core_A_sequencer seqr_A; 
core_B_sequencer seqr_B; 
`uvm_object_utils(virtual_seq) 
`uvm_declare_p_sequencer(virtual_sequencer) 
function new (string name = "virtual_seq"); 
super.new(name); 
endfunction 
task body(); 
`uvm_info(get_type_name(), "virtual_seq: Inside Body", UVM_LOW); 
Aseq = core_A_seq::type_id::create("Aseq"); 
Bseq = core_B_seq::type_id::create("Bseq"); 
Aseq.start(p_sequencer.seqr_A); 
Bseq.start(p_sequencer.seqr_B); 
endtask 
endclass 
 
// Virtual p_sequencer 
class virtual_sequencer extends uvm_sequencer; 
`uvm_component_utils(virtual_sequencer) 
core_A_sequencer seqr_A; 
core_B_sequencer seqr_B; 
function new(string name = "virtual_sequencer", uvm_component parent = null); 
super.new(name, parent); 
endfunction 
endclass 
