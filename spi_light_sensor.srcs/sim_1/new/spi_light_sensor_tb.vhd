----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/01/2025 12:01:46 PM
-- Design Name: 
-- Module Name: spi_light_sensor_tb - TB
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
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_spi_light_sensor is
end entity;

architecture TB of tb_spi_light_sensor is

  -- Component under test
  component spi_light_sensor
    Port(
      --
      i_Switch_1 : in  std_logic;
      i_Clk      : in  std_logic;

      --
      o_Segment1_A : out std_logic;
      o_Segment1_B : out std_logic;
      o_Segment1_C : out std_logic;
      o_Segment1_D : out std_logic;
      o_Segment1_E : out std_logic;
      o_Segment1_F : out std_logic;
      o_Segment1_G : out std_logic;
      o_Segment2_A : out std_logic;
      o_Segment2_B : out std_logic;
      o_Segment2_C : out std_logic;
      o_Segment2_D : out std_logic;
      o_Segment2_E : out std_logic;
      o_Segment2_F : out std_logic;
      o_Segment2_G : out std_logic;


      o_SPI_Clk    : out std_logic;
      i_SPI_MISO   : in  std_logic;
      o_SPI_MOSI   : out std_logic;
      o_SPI_CS_n   : out std_logic
    );
  end component;

  -- Signals
  signal s_Clk         : std_logic := '0';
  signal s_Switch_1    : std_logic := '0';
  signal s_SPI_Clk     : std_logic;
  signal s_SPI_CS_n    : std_logic;
  signal s_SPI_MOSI    : std_logic;
  signal s_SPI_MISO    : std_logic := '0';  -- Emulated from ADC
  signal s_Segments    : std_logic_vector(13 downto 0); -- All 14 segments

  -- Internal variables to emulate ADC SPI output
  signal spi_miso_data : std_logic_vector(15 downto 0) := X"A5C0"; -- ADC output word
  signal bit_index     : integer := 15;

begin

  -- Clock generator: 25 MHz clock (period = 40 ns)
  clk_gen: process
  begin
    s_Clk <= '0';
    wait for 20 ns;
    s_Clk <= '1';
    wait for 20 ns;
  end process;

  -- MISO emulation: shift out spi_miso_data during SPI clock when CS is low
  spi_slave_emulator: process(s_SPI_Clk)
  begin
    if falling_edge(s_SPI_Clk) then  -- SPI reads on falling edge for CPHA=1
      if s_SPI_CS_n = '0' then
        s_SPI_MISO <= spi_miso_data(bit_index);
        if bit_index = 0 then
          bit_index <= 15;
        else
          bit_index <= bit_index - 1;
        end if;
      else
        bit_index <= 15;
        s_SPI_MISO <= '0';
      end if;
    end if;
  end process;

  -- Instantiate Unit Under Test
  UUT : entity work.spi_light_sensor

    port map (
      i_Switch_1 => s_Switch_1,
      i_Clk      => s_Clk,

      o_Segment1_A => s_Segments(0),
      o_Segment1_B => s_Segments(1),
      o_Segment1_C => s_Segments(2),
      o_Segment1_D => s_Segments(3),
      o_Segment1_E => s_Segments(4),
      o_Segment1_F => s_Segments(5),
      o_Segment1_G => s_Segments(6),
      o_Segment2_A => s_Segments(7),
      o_Segment2_B => s_Segments(8),
      o_Segment2_C => s_Segments(9),
      o_Segment2_D => s_Segments(10),
      o_Segment2_E => s_Segments(11),
      o_Segment2_F => s_Segments(12),
      o_Segment2_G => s_Segments(13),

      o_SPI_Clk    => s_SPI_Clk,
      i_SPI_MISO   => s_SPI_MISO,
      o_SPI_MOSI   => s_SPI_MOSI,
      o_SPI_CS_n   => s_SPI_CS_n
    );

  -- Stimulus process
  stim_proc: process
  begin
    -- Hold reset low initially
    s_Switch_1 <= '0';
    wait for 200 ns;

    -- Release reset
    s_Switch_1 <= '1';
    wait for 20 us;

    -- End simulation
    assert false report "Simulation finished." severity note;
    wait;
  end process;

end architecture;
