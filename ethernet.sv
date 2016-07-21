`include "uvm_macros.svh"
import uvm_pkg::*;

class eth_pkt extends uvm_object;
	rand bit [47:0] preamble;
	rand bit [47:0] dstaddr;
	rand bit [47:0] srcaddr;
	rand bit [9:0] 	len;
	rand byte payload[$];
	int count;// to store number of packets generated
	`uvm_object_utils_begin(eth_pkt)
		`uvm_field_int(preamble,UVM_DEC)	
		`uvm_field_int(dstaddr,UVM_DEC)
		`uvm_field_int(srcaddr,UVM_DEC)
		`uvm_field_int(len,UVM_DEC)
		`uvm_field_queue_int(payload,UVM_DEC)
	`uvm_object_utils_end
	function new (string name="eth_pkt");
		super.new(name);
	endfunction: new
	constraint len_c {
		len>0;len<1000;
	}
	constraint preamble_c {
		preamble>0 ; preamble<1000;
	}	
	constraint dstaddr_c {
		dstaddr>500;dstaddr<1000;
	}
	constraint srcaddr_c {
		srcaddr>0;srcaddr<500;
	}
	constraint payload_c {
		payload.size()==len;
	}
	constraint src_dst_addr_c {
		srcaddr!=dstaddr;
	}	
endclass: eth_pkt 

module object_automation_usage;
eth_pkt pktA,pktB;
initial begin
	pktA=eth_pkt::type_id::create("pktA");// Create a packet and register to Factory
	assert(pktA.randomize());//Randomize the fields of packet and flag if fails
	pktA.print();//call using inbuilt uvm print function
end
endmodule: object_automation_usage
