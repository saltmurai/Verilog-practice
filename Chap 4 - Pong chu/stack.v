module stack 
    #(
        parameter B = 8, //number of bits in a word
                  W = 4 //number of adderess bit
    )
    (
        input wire clk, reset,
        input wire push, pop,
        input wire [B-1:0] push_data,
        output wire empty, full,
        output wire [B-1:0] pop_data
    );

//signal declaration
    reg [B - 1:0] array_reg [2**W-1:0]; //register array
    //reg [W - 1:0] push_ptr_reg, push_ptr_next, push_ptr_succ;
    //reg [W - 1:0] pop_ptr_reg, pop_ptr_next, pop_ptr_succ;
    reg [W - 1:0] ptr_reg, ptr_next, ptr_succ, ptr_prev;
    reg full_reg, empty_reg, full_next, empty_next;



    wire push_en;

    //body
    //register file push operation

    always @(posedge clk) begin
        if(push_en)
            array_reg[ptr_reg] <= push_data;
    end

    assign pop_data = array_reg[ptr_reg];
    assign push_en = push & ~full_reg;


    //stack control logic
    //register for read and write pointers

    always @ (posedge clk, posedge reset) begin
        if (reset)
            begin
                ptr_reg <= 0;
                full_reg <= 0;
                empty_reg <= 1;
            end
        else
            begin 
                ptr_reg <= ptr_next;
                full_reg <= full_next;
                empty_reg <= empty_next;
            end 
    end
    //next-state logic for push and pop
    always @(*) begin
        ptr_succ = ptr_reg + 1;
        if (ptr_reg)
            ptr_prev = ptr_reg - 1;
        else
            ptr_prev = ptr_reg;
    //default: keep old values;
        ptr_next = ptr_reg;
        full_next = full_reg;
        empty_next = empty_reg;
        case ({push, pop})
            2'b01: //pop
                if(~empty_reg) begin
                    ptr_next = ptr_prev;
                    full_next = 1'b0;
                    if (ptr_prev==0)
                        empty_next = 1'b1;
                end
            2'b10: 
                if (~full_reg) begin
                    ptr_next = ptr_succ;
                    empty_next = 1'b0;
                    if(ptr_next == 2**W - 1)
                        full_next = 1'b1;
                //full check
                end
        endcase
    end
    assign full = full_reg;
    assign empty = empty_reg;

endmodule