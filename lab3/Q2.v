module genvar_tb();
generate
  genvar i;
  for (i = 0; i < 5; i = i + 1)
    begin : gen1
      genvar j;
      for (j = i; j >= 1; j = j - 1)
        begin : gen2
          reg [0:i] R;
          initial
            begin
              R = i;
              $display("%m", R);
            end
        end
    end
endgenerate
endmodule