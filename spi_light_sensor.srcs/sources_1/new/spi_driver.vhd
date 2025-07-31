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
        o_TX_Ready  : out   std_logic;                      --Low during Transmit
        i_TX_DV     : in    std_logic;                     -- Pulse to indicate byte is ready
        i_TX_Byte   : in    std_logic_vector(7 downto 0);  -- Byte to send via SPI

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
    
    signal r_TX_DV              : std_logic;            -- 1 cycle delayed of i_TX_DV, used to avoid timing issues.
    signal r_TX_Byte            : std_logic;            -- Stores a copy of the byte being transfered to avoid data being lost.

    signal r_TX_Bit_Count       : Unsigned(2 downto 0);
    signal r_RX_Bit_Count       : Unsigned(2 downto 0);

begin
    
    -- 
    w_CPOL <= '1' when (SPI_MODE = 2) or (SPI_MODE = 3) else '0';

    -- 
    w_CPHA <= '1' when (SPI_MODE = 1) or (SPI_MODE = 3) else '0';


    -- Generate SPI Clk when DV is pulled high
    Edge_Indicator : process(i_Clk, i_nRst) 
    begin
        if i_nRst = '0'; then
            -- all to default
            o_TX_Ready          <= '0';
            r_SPI_Clk_Count     <= 0;
            r_SPI_Clk_Edges     <= 0;
            r_SPI_Leading_Edge  <= '0';
            r_SPI_Trailing_Edge <= '0';
            r_SPI_Clk           <= w_CPOL; -- Default idle state.


        elsif rising_edge(i_Clk) then
            
            -- Default edge indicators 
            r_Leading_Edge  <= '0';
            r_Trailing_Edge <= '0';

            -- Transmission begins
            -- if we have valid data to send -> disable o_TX_Ready and Initializ r_SPI_Clk_Edges
            if i_TX_DV = '1' then
                o_TX_Ready      <= '0';
                r_SPI_Clk_Edges <= 16;

            -- Transmitting
            elsif r_SPI_Clk_Edges > 0 then -- Still not 0 so keep transmitting.
                o_TX_Ready <= '0';

                -- Toggle the SPI clock, every full SPI period.
                if r_SPI_Clk_Count = CLKS_PER_HALF_BIT *2 -1 then
                    r_SPI_Clk_edges     <= r_SPI_Clk_Edges -1;
                    r_SPI_Trailing_Edge <= '1'; -- Happens after full SPI Clk period.
                    r_SPI_Clk_Count     <= 0; -- Restart the counter
                    r_SPI_Clk           <= not r_SPI_Clk;
                
                
                -- Half SPI clk passed, now we toggle the Leading edge.
                elsif r_SPI_Clk_Count = CLKS_PER_HALF_BIT -1 then
                    r_SPI_Leading_Edge  <= '1';
                    r_SPI_Clk_Count     <= r_SPI_Clk_Count +1; 
                    r_SPI_Clk           <= not r_SPI_Clk ;  

                -- Keep counting
                else 
                    r_SPI_Clk_Count = r_SPI_Clk_Count;
                end if;
            

        -- Idle state, not transmitting 
        else
            o_TX_Ready = '1'; -- Ready to transmit next byte. 
        end if;
    end if;

    end process Edge_Indicator;


    -- Registers the input byte (i_TX_Byte), when i_TX_DV signal is pulsed.
    -- Handles Receiving the byte to be sent.
    -- i_TX_DV = 1
    Byte_Reg : process(i_Clk, i_nRst)
    begin
        if i_nRst = '0'; then
            i_TX_DV     <= '0';
            i_TX_Byte   <= X"00";
        elsif rising_edge(i_Clk) then
            r_TX_DV     <= i_TX_DV;
            if i_TX_DV '1' then 
                r_TX_Byte   <= i_TX_Byte;
            end if;
        end if;
    end process Byte_Reg;



    
    -- Generates MOSI bitsream, sends one bit per clock edge 
    -- Sends bit to o_SPI_MOSI
    -- Trigger: SPI clock edges



end RTL;
