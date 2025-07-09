// With virtual sequence and without a virtual sequencer 
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
`uvm_info(get_type_name(), "virtual_seq: Inside Body", UVM_LOW); 
Aseq = core_A_seq::type_id::create("Aseq"); 
Bseq = core_B_seq::type_id::create("Bseq"); 
Aseq.start(seqr_A); 
Bseq.start(seqr_B); 
endtask 
endclass 
 
// No Virtual sequencer 
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
