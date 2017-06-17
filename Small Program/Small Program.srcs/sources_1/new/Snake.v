`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/17/2017 09:57:13 AM
// Design Name: 
// Module Name: Snake
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//���˶��������ģ��
module Snake
(
	input clk,
	input rst,
	
	input[15:0] point,
	input left_press,
	input right_press,
	input up_press,
	input down_press,
	
	output reg [1:0]snake,//���ڱ�ʾ��ǰɨ��ɨ��Ĳ��� ����״̬ 00���� 01��ͷ 10������ 11��ǽ
	
	input [9:0]x_pos,
	input [9:0]y_pos,//ɨ������  ��λ��"���ص�"
	
	output [5:0]head_x,	
	output [5:0]head_y,//ͷ��������
	
	input add_cube,//�����峤�ź�
	
	input [1:0]game_status,//������Ϸ״̬
	
	output reg [6:0]cube_num,
	
	output reg hit_body,   //ײ�������ź�
	output reg hit_wall,   //ײ��ǽ�ź�
	input die_flash        //�����ź�
);
	
	localparam UP = 2'b00;
	localparam DOWN = 2'b01;
	localparam LEFT = 2'b10;
	localparam RIGHT = 2'b11;
	
	localparam NONE = 2'b00;
	localparam HEAD = 2'b01;
	localparam BODY = 2'b10;
	localparam WALL = 2'b11;
	
    localparam RESTART = 2'b00;
	localparam PLAY = 2'b10;
	
	reg[31:0]cnt;
	
	reg[31:0] cnt_lv1 = 32'd12_500_000;
	reg[31:0] cnt_lv2 = 32'd62_500_00;
	
	wire[1:0]direct;
	reg [1:0]direct_r;     //�Ĵ淽��
	assign direct = direct_r;//�Ĵ���һ������
	reg[1:0]direct_next;
	
	reg change_to_left;
	reg change_to_right;
	reg change_to_up;
	reg change_to_down;
	
	reg [5:0]cube_x[15:0];
	reg [5:0]cube_y[15:0];//�峤���� ��λ��"����" 
	reg [15:0]is_exist;    //���ڿ������ӵ����𣬼��������ӳ���
	
	reg addcube_state;
	
	assign head_x = cube_x[0];
	assign head_y = cube_y[0]; 
	
	always @(posedge clk or negedge rst) begin		
		if(!rst)
			direct_r <= RIGHT; //Ĭ��һ���������ƶ�
		else if(game_status == RESTART) 
		    direct_r <= RIGHT;
		else
			direct_r <= direct_next;
	end

    
	
	
	always @(posedge clk or negedge rst) begin
//����ƻ��û����������add_cube==1����ʾ�峤����һλ��"is_exixt[cube_num]<=1",�õ�cube_numλ"����"		
		if(!rst) begin
			is_exist <= 16'd7;
			cube_num <= 3;
			addcube_state <= 0;//��ʼ��ʾ����Ϊ3��is_exist=0000_0000_0111,��ʾǰ��λ����
		end  
		else if (game_status == RESTART) begin
		      is_exist <= 16'd7;
              cube_num <= 3;
              addcube_state <= 0;
         end
		else begin			
			case(addcube_state) //�ж���ͷ��ƻ�������Ƿ��غ�
				0:begin
					if(add_cube) begin
						cube_num <= cube_num + 1;
						is_exist[cube_num] <= 1;
						addcube_state <= 1;//"����"�ź�
					end						
				end
				1:begin
					if(!add_cube)
						addcube_state <= 0;				
				end
			endcase
		end
	end
	
	reg[3:0]lox;
	reg[3:0]loy;
	
	always @(x_pos or y_pos ) begin				
		if(x_pos >= 0 && x_pos < 640 && y_pos >= 0 && y_pos < 480) begin
			if(x_pos[9:4] == 0 | y_pos[9:4] == 0 | x_pos[9:4] == 39 | y_pos[9:4] == 29)
				snake = WALL;//ɨ��ǽ
			else if(x_pos[9:4] == cube_x[0] && y_pos[9:4] == cube_y[0] && is_exist[0] == 1) 
				snake = (die_flash == 1) ? HEAD : NONE;//ɨ��ͷ
			else if
				((x_pos[9:4] == cube_x[1] && y_pos[9:4] == cube_y[1] && is_exist[1] == 1)|
				 (x_pos[9:4] == cube_x[2] && y_pos[9:4] == cube_y[2] && is_exist[2] == 1)|
				 (x_pos[9:4] == cube_x[3] && y_pos[9:4] == cube_y[3] && is_exist[3] == 1)|
				 (x_pos[9:4] == cube_x[4] && y_pos[9:4] == cube_y[4] && is_exist[4] == 1)|
				 (x_pos[9:4] == cube_x[5] && y_pos[9:4] == cube_y[5] && is_exist[5] == 1)|
				 (x_pos[9:4] == cube_x[6] && y_pos[9:4] == cube_y[6] && is_exist[6] == 1)|
				 (x_pos[9:4] == cube_x[7] && y_pos[9:4] == cube_y[7] && is_exist[7] == 1)|
				 (x_pos[9:4] == cube_x[8] && y_pos[9:4] == cube_y[8] && is_exist[8] == 1)|
				 (x_pos[9:4] == cube_x[9] && y_pos[9:4] == cube_y[9] && is_exist[9] == 1)|
				 (x_pos[9:4] == cube_x[10] && y_pos[9:4] == cube_y[10] && is_exist[10] == 1)|
				 (x_pos[9:4] == cube_x[11] && y_pos[9:4] == cube_y[11] && is_exist[11] == 1)|
				 (x_pos[9:4] == cube_x[12] && y_pos[9:4] == cube_y[12] && is_exist[12] == 1)|
				 (x_pos[9:4] == cube_x[13] && y_pos[9:4] == cube_y[13] && is_exist[13] == 1)|
				 (x_pos[9:4] == cube_x[14] && y_pos[9:4] == cube_y[14] && is_exist[14] == 1)|
				 (x_pos[9:4] == cube_x[15] && y_pos[9:4] == cube_y[15] && is_exist[15] == 1))
				 snake = (die_flash == 1) ? BODY : NONE;//ɨ������
			else snake = NONE;
		end
	end
	
			
endmodule


