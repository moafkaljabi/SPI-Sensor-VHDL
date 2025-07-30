----------------------------------------------------------------------------------
-- Company: Astraspecs
-- Engineer: Moafk Aljabi
-- 
-- Create Date: 07/29/2025 05:00:40 PM
-- Design Name: 
-- Module Name: spi_light_sensor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
-- Operating clk should be 2x SPI clk
-- 

----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity spi_light_sensror is 
    Port(
        -- Clock and Reset
        i_RST   :   in  std_logic;
        i_Clk   :   in  std_logic;

        -- SPI PMOD pins        
        o_SPI_Clk   : out   std_logic;
        i_SPI_MISO  : in    std_logic;
        o_SPI_MOSI  : out   std_logic;
        o_SPI_CS_N  : out   std_logic;  

        -- Display, 1st Digit
        o_Segment1_A    : out   std_logic;
        o_Segment1_B    : out   std_logic;
        o_Segment1_C    : out   std_logic;
        o_Segment1_D    : out   std_logic;
        o_Segment1_E    : out   std_logic;
        o_Segment1_F    : out   std_logic;
        o_Segment1_G    : out   std_logic;

        -- Display, 2nd Digit
        o_Segment2_A    : out   std_logic;
        o_Segment2_B    : out   std_logic;
        o_Segment2_C    : out   std_logic;
        o_Segment2_D    : out   std_logic;
        o_Segment2_E    : out   std_logic;
        o_Segment2_F    : out   std_logic;
        o_Segment2_G    : out   std_logic
    );

end entity;

architecture RTL of spi_light_sensor is

    
    -- Setup Clock and Reset
    -- Clock 100 MHz

    
    -- Setup SPI mode 0-3

    -- SPI Signals

begin

    -- generic map 
    
    
    -- port map

    
    -- process to handle read requests from ADC

    
    -- Process to handle data being read back from SPI
    -- Sets the respons into a single 8-bit ADC value


    -- Remove the trailing and leading 0s.

    


    -- Control the brightness of the display depending
    -- on the ADC value; 255 is max, 0 is off.

end RTL;
    