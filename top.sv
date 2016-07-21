module object_automation_usage;
eth_pkt pktA,pktB;
initial begin
	pktA=eth_pkt::type_id::create("pktA");
	assert(pktA.randomize());
	pktA.print();
end

endmodule: object_automation_usage	
