module fulladder (input a, b, cin,
                  output reg s, cout);
    reg p, g;
    always @ (*)    
        begin
        p = a ^ b; // blocking
        g = a & b; // blocking
        s = p ^ cin; // blocking
        cout = g | (p & cin); // blocking
end
endmodule