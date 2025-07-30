#########################################
# SPI Sensor on PMOD1 (lower 6 pins)
#########################################

set_property PACKAGE_PIN G13 [get_ports spi_sclk]
set_property IOSTANDARD LVCMOS33 [get_ports spi_sclk]

set_property PACKAGE_PIN G14 [get_ports spi_mosi]
set_property IOSTANDARD LVCMOS33 [get_ports spi_mosi]

set_property PACKAGE_PIN H13 [get_ports spi_miso]
set_property IOSTANDARD LVCMOS33 [get_ports spi_miso]

set_property PACKAGE_PIN H14 [get_ports spi_cs]
set_property IOSTANDARD LVCMOS33 [get_ports spi_cs]

# Optional 2 more pins (if needed for future)
# set_property PACKAGE_PIN J13 [get_ports extra_1]
# set_property PACKAGE_PIN J14 [get_ports extra_2]

#########################################
# 7-Segment Display on PMOD2 (all 12 pins)
#########################################

# Segments a-g
set_property PACKAGE_PIN K13 [get_ports seg_a]
set_property IOSTANDARD LVCMOS33 [get_ports seg_a]

set_property PACKAGE_PIN K14 [get_ports seg_b]
set_property IOSTANDARD LVCMOS33 [get_ports seg_b]

set_property PACKAGE_PIN L13 [get_ports seg_c]
set_property IOSTANDARD LVCMOS33 [get_ports seg_c]

set_property PACKAGE_PIN L14 [get_ports seg_d]
set_property IOSTANDARD LVCMOS33 [get_ports seg_d]

set_property PACKAGE_PIN M13 [get_ports seg_e]
set_property IOSTANDARD LVCMOS33 [get_ports seg_e]

set_property PACKAGE_PIN M14 [get_ports seg_f]
set_property IOSTANDARD LVCMOS33 [get_ports seg_f]

set_property PACKAGE_PIN N13 [get_ports seg_g]
set_property IOSTANDARD LVCMOS33 [get_ports seg_g]

# Digit select lines (assuming 2 digits)
set_property PACKAGE_PIN N14 [get_ports digit1_en]
set_property IOSTANDARD LVCMOS33 [get_ports digit1_en]

set_property PACKAGE_PIN P13 [get_ports digit2_en]
set_property IOSTANDARD LVCMOS33 [get_ports digit2_en]

# Optional: decimal point, unused pin, etc.
# set_property PACKAGE_PIN P14 [get_ports unused]
# set_property IOSTANDARD LVCMOS33 [get_ports unused]

#########################################
# User LEDs (example: PL LEDs or EMIO)
#########################################

# Assuming directly connected to PL pins:
set_property PACKAGE_PIN R13 [get_ports led_0]
set_property IOSTANDARD LVCMOS33 [get_ports led_0]

set_property PACKAGE_PIN R14 [get_ports led_1]
set_property IOSTANDARD LVCMOS33 [get_ports led_1]
