# Version:1.0 MMMC View Definition File
# Do Not Remove Above Line

# need to manually specify name because Cadence overrides it into a temp file

# ===== Create Library Set ===== #
create_library_set \
		 -name fast_libs \
		 -timing [ list \
				 "$::config::RESOURCES/cadence_sky130/sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_ff_1.98_0_nldm.lib" \
				 "$::config::RESOURCES/cadence_sky130/sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lib/sky130_ff_1.98_0_nldm.lib" \
				 "$::config::RESOURCES/cadence_sky130/sky130_scl_9T_0.1.2/sky130_scl_9T_tech/lib/sky130_scl_9T_phyCells.lib" \
				 "$::config::INPUTS/CF_SRAM_1024x32/lib/CF_SRAM_1024x32_tt_180V_100C.lib" \
		]

create_library_set \
	 -name typical_libs \
	 -timing [ list \
			 "$::config::RESOURCES/cadence_sky130/sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_tt_1.8_25_nldm.lib" \
				 "$::config::RESOURCES/cadence_sky130/sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lib/sky130_tt_1.8_25_nldm.lib" \
	     	 "$::config::RESOURCES/cadence_sky130/sky130_scl_9T_0.1.2/sky130_scl_9T_tech/lib/sky130_scl_9T_phyCells.lib" \
			 "$::config::INPUTS/CF_SRAM_1024x32/lib/CF_SRAM_1024x32_tt_180V_100C.lib" \
		]

create_library_set \
		 -name slow_libs \
		 -timing [ list \
				 "$::config::RESOURCES/cadence_sky130/sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_ss_1.62_125_nldm.lib" \
				 "$::config::RESOURCES/cadence_sky130/sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lib/sky130_ss_1.62_125_nldm.lib" \
				 "$::config::RESOURCES/cadence_sky130/sky130_scl_9T_0.1.2/sky130_scl_9T_tech/lib/sky130_scl_9T_phyCells.lib" \
				 "$::config::INPUTS/CF_SRAM_1024x32/lib/CF_SRAM_1024x32_tt_180V_100C.lib" \
		]

# ===== Create RC Corner ===== #
create_rc_corner \
    -name typical_rc \
    -T {25} \
    -qx_tech_file "$::config::RESOURCES/cadence_sky130/sky130_release_0.1.0/quantus/extraction/typical/qrcTechFile" \
    -preRoute_res {1} \
    -preRoute_cap {1} \
    -postRoute_res {1} \
    -postRoute_cap {1} \
    -postRoute_xcap {1} \
    -preRoute_clkres {0} \
    -preRoute_clkcap {0} \
    -postRoute_clkres {0} \
    -postRoute_clkcap {0}

# ===== Create Operation Condition ===== #
create_op_cond \
		 -name ff_1.98_0 \
		 -library_file "$::config::RESOURCES/cadence_sky130/sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_ff_1.98_0_nldm.lib" \
		 -P {1} \
		 -V {1.98} \
		 -T {0}

create_op_cond \
		 -name tt_1.8_25 \
	 -library_file "$::config::RESOURCES/cadence_sky130/sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_tt_1.8_25_nldm.lib" \
	 -P {1} \
	 -V {1.8} \
	 -T {25}

create_op_cond \
		 -name ss_1.62_125 \
		 -library_file "$::config::RESOURCES/cadence_sky130/sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_ss_1.62_125_nldm.lib" \
		 -P {1} \
		 -V {1.62} \
		 -T {125}

# ===== Create Delay Corner ===== #
create_delay_corner \
		 -name fast_delay_corner \
		 -library_set {fast_libs} \
	     -opcond ff_1.98_0 \
		 -rc_corner {typical_rc}

create_delay_corner \
	 -name typical_delay_corner \
	 -library_set {typical_libs} \
	     -opcond tt_1.8_25 \
	 -rc_corner {typical_rc}

create_delay_corner \
		 -name slow_delay_corner \
		 -library_set {slow_libs} \
	     -opcond ss_1.62_125 \
		 -rc_corner {typical_rc}

# ===== Create Constraint Mode ===== #
create_constraint_mode \
	 -name default \
	 -sdc_files [ list \
                 "$::config::DESIGN_ROOT/outputs/synthesis/$::config::DESIGN.sdc" \
                ]

# ===== Create Analysis View ===== #
create_analysis_view \
		 -name fast_analysis_view \
		 -constraint_mode {default} \
		 -delay_corner {fast_delay_corner}

create_analysis_view \
	 -name typical_analysis_view \
	 -constraint_mode {default} \
	 -delay_corner {typical_delay_corner}

create_analysis_view \
		 -name slow_analysis_view \
		 -constraint_mode {default} \
		 -delay_corner {slow_delay_corner}

# ===== Set Analysis View ===== #
set_analysis_view \
	 -setup {typical_analysis_view} \
	 -hold {typical_analysis_view}
