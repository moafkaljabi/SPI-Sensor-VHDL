----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/30/2025 09:15:40 PM
-- Design Name: 
-- Module Name: spi_driver - RTL
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_driver is
    generic(
        SPI_MODE            in  integer = 0;
        CLKS_PER_HALF_BIT   in  integer = 12;
    );

    port (
        -- Control Signals
        i_Clk   : in    std_logic;
        i_nRst  : in    std_logic

        -- Transmit Signals
        o_TX_Ready  : out   std_logic;
        i_TX_DV     : in    std_logic;
        i_TX_Byte   : in    std_logic_vector(7 downto 0);

        -- Receive Signals
        o_RX_DV     : out   std_logic;
        o_RX_Byte   : out   std_logic_vector(7 downto 0);
        
        -- SPI Interface
        o_SPI_Clk   : out   std_logic;
        o_SPI_MOSI  : out   std_logic;
        i_SPI_MISO  : in    std_logic
    );

end spi_driver;

architecture RTL of spi_driver is

    -- SPI Interface
    signal w_CPOL   : std_logic;
    signal w_CPHA   : std_logic;

    -- 
    signal r_SPI_Clk_Count      : integer range 0 to CLKS_PER_HALF_BIT *2 -1 ;
    signal r_SPI_Clk            : std_logic;
    signal r_SPI_Clk_Edges      : std_logic_vector range 0 to 16;
    signal r_SPI_Leading_Edge   : std_logic;
    signal r_SPI_Trailing_Edge  : std_logic;
    
    signal r_TX_DV              : std_logic;
    signal r_TX_Byte            : std_logic;

    signal r_TX_Bit_Count       : Unsigned(2 downto 0);
    signal r_RX_Bit_Count       : Unsigned(2 downto 0);

begin
    
    -- 
    w_CPOL <= '1' when (SPI_MODE = 2) or (SPI_MODE = 3) else '0';

    -- 
    w_CPHA <= '1' when (SPI_MODE = 1) or (SPI_MODE = 3) else '0';


    -- Generate SPI Clk when DV is pulled high
    Edge_Indicator 



end RTL;
