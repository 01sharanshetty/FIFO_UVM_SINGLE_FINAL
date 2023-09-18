module SYN_FIFO(
  input wire clk,             // Clock signal
  input wire rst,             // Reset signal
  input wire write_en,        // Write enable
  input wire read_en,         // Read enable
  input wire [127:0] data_in, // Input data
  output wire [127:0] data_out, // Output data
  output wire full,           // Full signal
  output wire almost_full,    // Almost Full signal (4 spaces left)
  output wire empty,          // Empty signal
  output wire almost_empty    // Almost Empty signal (2 spaces filled)
);

 

  // FIFO parameters
  parameter DEPTH = 5;
  parameter WIDTH = 128;

 

  // Internal FIFO storage
  reg [WIDTH-1:0] fifo[0:DEPTH-1];
  reg [9:0] write_ptr;
  reg [9:0] read_ptr;
  reg [127:0] out;
  wire [9:0] fifo_count = write_ptr - read_ptr;
  wire almost_full_condition = (fifo_count >= (DEPTH - 4));
  wire almost_empty_condition = (fifo_count <= 2);
// Full and Empty signals
  assign full = (fifo_count >= (DEPTH));
  assign almost_full = (almost_full_condition && !full);
  assign empty = (fifo_count == 0);
  assign almost_empty = (almost_empty_condition && !empty);

 

  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      write_ptr <= 0;
      read_ptr <= 0;
      
    end
    
    
  else  if (write_en && !read_en) begin
      fifo[write_ptr] <= data_in;
      write_ptr <= write_ptr + 1;
    end
    
 
      

   else if (read_en && !write_en) begin

        out <= fifo[read_ptr];
        read_ptr <= read_ptr + 1; 
    end
    
    else if (write_en && read_en) begin
      write_ptr=0;
      read_ptr=0;
      fifo[write_ptr] = data_in;
      out = fifo[read_ptr];
    end
    
    else if (!write_en && !read_en) begin
      write_ptr=0;
      read_ptr=0;
      fifo[write_ptr] = 0;
      out = fifo[read_ptr];
    end
  end

 
// Assign data_out outside of procedural blocks
  assign data_out = out;

endmodule