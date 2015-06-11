require 'active_support/inflector'
require 'active_support/core_ext/array'

module YARD::Handlers::Ruby::ActiveRecord::Validate

  # Links with a value of nil will be link to
  # the Rails Validations guide.
  # Other projects can add to the
  STANDARD_LINKS = [
    :acceptance,
    :validates_associated,
    :confirmation,
    :exclusion,
    :format,
    :inclusion,
    :length,
    :numericality,
    :presence,
    :absence,
    :uniqueness,
    :validates_with,
    :validates_each
  ]

  #def self.add_validation_type( type )
    # custom types added
    @custom_types = [
                     :check_timecode_source,
                     :stream_outputs_check,
                     :absence_of_precedence,
                     :adaptive_quantization_check,
                     :admin_user_exists,
                     :afd_check,
                     :alert_check,
                     :allowed_input_format_values,
                     :alternate_scc_uri_bank_if_scc_xml,
                     :aq_range,
                     :audio_codec_check,
                     :audio_only_object_check,
                     :b_frame_profile_check,
                     :b_frames_check,
                     :backup_rule_check,
                     :backup_rule_validation,
                     :baseline_interlace_check,
                     :bitmap_validations,
                     :bitrate_check,
                     :blackout_input_group_check,
                     :bonded_settings_check,
                     :cabac_check,
                     :cannot_change_when_part_of_schedule,
                     :caption_extractions_check,
                     :cdn_destination_check,
                     :channel_mapping_check,
                     :check_email_and_web_callback_exists,
                     :check_enabled,
                     :check_encryption_settings,
                     :check_event_exists,
                     :check_font_size,
                     :check_font_uri,
                     :check_for_same_keys,
                     :check_heartbeat,
                     :check_instruction,
                     :check_keyprovider_server,
                     :check_name,
                     :check_pat_and_pmt_intervals,
                     :check_remix_settings,
                     :check_server_certificates_validity,
                     :check_start_and_end_timecodes_not_both_blank,
                     :check_staticf_key_value,
                     :check_timing_values_with_markers,
                     :check_type_matches,
                     :coding_mode_bitrate_check,
                     :coding_mode_bitstream_check,
                     :coding_mode_profile_check,
                     :container_compatibility_check,
                     :correction_gate_level_check,
                     :cpu_excluded_fields,
                     :cq_2_pass_check,
                     :create_with_params_deprecation_check,
                     :create_without_params_deprecation_check,
                     :d10_syntax_check,
                     :deg_c_check,
                     :delete_and_move,
                     :destination_check,
                     :destination_valid,
                     :directory_loop_check,
                     :disallow_s3,
                     :dual_mono_sample_rate_check,
                     :encryption_check,
                     :ensure_image_inserter_disabled,
                     :ensure_no_destnation_basenames,
                     :eth_config_check,
                     :eth_configs_check,
                     :external_output_groups_check,
                     :fec_destination_check,
                     :filter_is_supported,
                     :flicker_reduction_gpu_check,
                     :force_field_pictures_check,
                     :force_password_expired_check,
                     :frame_size_check,
                     :framerate_check,
                     :framerate_follow,
                     :global_notification_check,
                     :gop_closed_cadence_with_follow,
                     :has_global_notification_changed,
                     :has_input_with_schedule,
                     :has_reason_to_exist,
                     :hostname_check,
                     :hot_backup_check,
                     :image_inserter_check,
                     :infer_external_filename_valid,
                     :input_check,
                     :input_mix_check,
                     :input_source_check,
                     :inputs_count_check,
                     :inputs_outputs_check,
                     :interlace_mode_check,
                     :interpolate_frc_check,
                     :level_check,
                     :lfe_filter_check,
                     :live_passes_limit,
                     :low_latency_mode_compatibility_check,
                     :m2ts_settings_bitrate_check,
                     :major_brand_check,
                     :max_greater_than_or_equal_to_min,
                     :max_less_than_authorized_node_count,
                     :mcc_uri_blank_if_mcc_xml,
                     :mono_check,
                     :multi_gpu_check,
                     :name_check,
                     :nameserver_check,
                     :nfs_check,
                     :node_is_selectable,
                     :nodes_or_devices_check,
                     :not_found,
                     :ntp_server_check,
                     :ordered_after_validations,
                     :output_groups_check,
                     :outputs_check,
                     :par_follow,
                     :params_deprecation_check,
                     :pct_check,
                     :pct_sync_check,
                     :perform_conductor_license_check,
                     :port_check,
                     :presence_valid,
                     :preset_category_check,
                     :preset_errors_check,
                     :profile_level_check,
                     :provider_payload_and_strength_combined,
                     :qp_check,
                     :rate_control_mode_check,
                     :real_mount_point_check,
                     :real_time_correction_must_be_true_for_live,
                     :realtime_check,
                     :repeating_schedule_check,
                     :resolution_height_check,
                     :sample_rate_check,
                     :scc_uri_xor_scc_xml,
                     :scc_xml_mcc_xml_size,
                     :scd_with_follow,
                     :schedule_type_check,
                     :server_only,
                     :show_page_check,
                     :skip_license_check,
                     :slice_count_check,
                     :slow_pal_framerate_check,
                     :start_at_check,
                     :start_before_end_check,
                     :start_check,
                     :start_present_when_required,
                     :stream_check,
                     :stream_outputs_check,
                     :stretch_to_output_check,
                     :telecine_framerate_check,
                     :timecode_insertion_for_audio_only,
                     :timecode_insertion_for_ms_smooth_only,
                     :timecode_passthrough_check,
                     :timecode_passthrough_sei_timeout_check,
                     :track_check,
                     :transition_detection_check,
                     :ts_settings_bitrate_check,
                     :until_end_date_check,
                     :update_timings_check,
                     :updating_repeating_schedule_check,
                     :uri_check,
                     :uvu_settings_fragment_length_check,
                     :valid_email,
                     :valid_netmask,
                     :valid_timecode_config_for_audio_timecode_insertion,
                     :validate_destination_settings,
                     :validate_fec_inputs,
                     :validate_pid_format,
                     :validate_pid_range_format,
                     :validate_router_input_device,
                     :validate_uri,
                     :vbi_passthrough_check,
                     :vbr_mode_check,
                     :vc1_profile_checks,
                     :video_codec_check,
                     :vlan_id_within_range,
                     :weekly_type_check,
                     :weekly_type_count,
                     :xdcam_with_imx_and_teletext
                    ]
  #end

  def self.link_for_validation( type )
    if STANDARD_LINKS.include?( type )
      "http://edgeguides.rubyonrails.org/active_record_validations.html##{type}"
    elsif @custom_types.include? ( type )
      type
    else
      nil
    end
  end

  # Define validations tag for later use
  YARD::Tags::Library.define_tag("Validations", :validates )

  # Document ActiveRecord validations.
  # This handler handles the validates statement.
  # It will parse the list of fields, the validation types and their options,
  # and the optional :if/:unless clause.
  # It only handles the newer Rails ":validates" syntax and does not
  # recognize the older "validates_presence_of" type methods.
  class ValidatesHandler < YARD::Handlers::Ruby::MethodHandler
    namespace_only
    handles method_call(:validates)
    def process

      validations = {}
      attributes  = []
      conditions  = {}

      # Read each parameter to the statement and parse out
      # it's type and intent
      statement.parameters(false).compact.map do |param|
        # list types are options
        if param.type == :list
          param.each do | n |
            kw = n.jump(:label, :symbol_literal ).source.gsub(/:/,'')
            # if/unless are conditions that apply to all the validations
            if ['if','unless','on'].include?(kw)
              conditions[ kw ] = n.children.last.source
            else # otherwise it's type specific
              opts = n.jump(:hash)
              value = ( opts != n ) ? opts.source : nil
              validations[ kw ] = value
            end
          end
        elsif param.type == :symbol_literal
          attributes << param.jump(:ident, :kw, :tstring_content).source
        end
      end

      # abort in case we didn't parse anything
      return if validations.empty?

      # Loop through each attribute and set a tag on each
      attributes.each do | attribute |
        method_definition = namespace.instance_attributes[attribute.to_sym] || {}
        method = method_definition[:read]
        if ! method
          meths = namespace.meths(:all => true)
          method = meths.find {|m| m.name == attribute.to_sym }
        end
        # If the method isn't defined yet, go ahead and create one
        if ! method
          method = register YARD::CodeObjects::MethodObject.new(namespace, attribute )
          method.scope = :instance
          method.explicit = false
          method_definition[:read] = method
          namespace.instance_attributes[attribute.to_sym] = method_definition
        end
        tag = YARD::Tags::OptionTag.new(:validates, '', conditions ) #, [] )
        tag.types = {} #[]
        validations.each{ |arg,options|
          tag.types[ arg ] = options
        }
        method.docstring.add_tag tag
      end

    end
  end

end
