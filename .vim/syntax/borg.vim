" Copyright 2005 Google Inc.
" All Rights Reserved.
" Author: plakal@google.com (Manoj Plakal)
"
" borg.vim: Vim syntax file for Borg config files.
"
" Borg Config Language links:
" http://wiki.corp.google.com/twiki/bin/view/Main/BorgConfig
" http://wiki.corp.google.com/twiki/bin/view/Main/BorgcfgReleases
" //depot/google3/configlang
" //depot/google3/borg/configs
" 
" Usage:
"   - Either source the main google.vim file from
"     /usr/share/vim/google/google.vim
"
"   - Or do the following manually:
"     - Copy this file into ~/.vim/syntax/borg.vim
"     - Put this snippet into ~/.vim/filetype.vim
"         if exists("did_load_filetypes")
"           finish
"         endif
"         augroup filetypedetect
"           au! BufRead,BufNewFile *.borg setfiletype borg
"         augroup END
"     - Put this snippet into ~/.vimrc
"         filetype on
"         syntax on
"  

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Borgcfg is based on gcl; import all elements.
runtime! syntax/gcl.vim

" These are possible future keywords (from Marcel vL, via Ovidiu P).
syn keyword borgKeyword      mutable function

" Object definitions: services, jobs, packages, allocations, templates.
" Highlight both the keyword and the name of the defined object that
" follows the keyword. Except when they are preceded by a '.'
" which is the borg way of allowing attributes with these special names.
syn region  borgObjectDef    matchgroup=gclObjectKeyword 
                             \start="\<\.\@<!\(service\|job\|package\|allocation\|template\)\>" 
                             \matchgroup=gclObjectName 
                             \end="\<[A-Za-z_][A-Za-z0-9_\-]*\>" 
                             \oneline skipwhite keepend

" Sections within a Borg object. Note that not all sections can
" occur within all objects, but we punt on context-sensitivity
" for now since that would require us to parse Borg Config Language
" within the edit buffer. Keep both sections and attributes (below)
" in sync with `grep -- '->Get' google3/borg/configs/*.cc.
" TODO(plakal): perhaps have a shell command to extract a list of
" candidate names from the source to generate this vimscript section.
syn keyword borgCfgSection appclass args backend_info backends canaries
syn keyword borgCfgSection dependencies healthz_ports job_health_params monitor
syn keyword borgCfgSection monitoring options packages permissions requirements
syn keyword borgCfgSection resources runtime scheduling task_args update

" Attributes within sections. Note that not all attributes can
" occur within all sections, but we punt on context-sensitivity.
syn keyword borgCfgAttribute after alloc alloc_health_timeout_ms
syn keyword borgCfgAttribute allow_auto_update append_checksum attr_limits
syn keyword borgCfgAttribute autopar_extract autopilot autorestart_timeout binary
syn keyword borgCfgAttribute binary_package_names binary_version block_on_delete
syn keyword borgCfgAttribute cached cell check_seconds chroot chubby_dir cleanup
syn keyword borgCfgAttribute command constraints correct_shardinfo_filename cpu
syn keyword borgCfgAttribute critical_jobs_present critical_task_grace_period
syn keyword borgCfgAttribute criticaljobs daemon data_version dataversion
syn keyword borgCfgAttribute deadline default_url directory disk enforce_limits
syn keyword borgCfgAttribute exclusive file fileset gfs_cell global globaldir
syn keyword borgCfgAttribute group health_timeout_seconds healthz_timeout_ms
syn keyword borgCfgAttribute hostname install install_timeout level lockservice
syn keyword borgCfgAttribute managed_dirs master master_port
syn keyword borgCfgAttribute max_consecutive_failures max_dead_tasks
syn keyword borgCfgAttribute max_failing_tasks max_in_flight
syn keyword borgCfgAttribute max_initial_failures max_job_failures
syn keyword borgCfgAttribute max_pending_tasks max_per_rack
syn keyword borgCfgAttribute max_per_task_failures max_reschedules
syn keyword borgCfgAttribute max_restarts_per_hour_hint max_task_failures
syn keyword borgCfgAttribute max_tolerated_failures max_unhealthy_tasks
syn keyword borgCfgAttribute min_ms_since_last_failure
syn keyword borgCfgAttribute min_seconds_since_last_failure mode mpm_dir name
syn keyword borgCfgAttribute nameservice_type need_different_machines
syn keyword borgCfgAttribute num_canaries num_conns num_disks num_shards
syn keyword borgCfgAttribute package_binary parent parent pathvar per_task
syn keyword borgCfgAttribute pin_tasks_per_alloc_index pinned portname ports
syn keyword borgCfgAttribute post_install preemption_notice preload_packages
syn keyword borgCfgAttribute priority production_package_verification protocol
syn keyword borgCfgAttribute ram rate_limit_ms replicas reschedule_timeout_ms
syn keyword borgCfgAttribute reset_job_failure_counts revert_on_error
syn keyword borgCfgAttribute run_updater_on_borg schedule_type segment
syn keyword borgCfgAttribute server_type serving_port shard shard_step
syn keyword borgCfgAttribute shardinfo_dir shardinfo_ports shared_cpu
syn keyword borgCfgAttribute shared_disk shared_min_disks shared_num_disks
syn keyword borgCfgAttribute start_quorum static_port static_ports status_port
syn keyword borgCfgAttribute stop_time strict_confirmation_threshold
syn keyword borgCfgAttribute task_update_order timeout_secs type shared_ram
syn keyword borgCfgAttribute unsafe_attr_limits_update use_dns use_fileutil
syn keyword borgCfgAttribute user watch_duration_ms watch_interval_ms
syn keyword borgCfgAttribute watch_task_duration_ms watch_task_interval_ms
syn keyword borgCfgAttribute borgletparams account_child_mem_to_alloc
syn keyword borgCfgAttribute max_diskused_fraction timeout_seconds

" Borg's builtin functions. Keep this in sync with:
" grep -h ConfFunction::Register google3/borg/configs/*.cc
"   | cut -d\" -f 2 | sort | fmt -50 | sed 's/^/syn keyword borgBuiltin /'
" and also update gcl.vim
syn keyword borgBuiltin borg_chubby_name borg_dns_name canonical_bcl
syn keyword borgBuiltin chroot_pb_str debugger_command file_checksum
syn keyword borgBuiltin format_backends format_shardinfo
syn keyword borgBuiltin get_babysitter_tasks get_binary
syn keyword borgBuiltin get_job_bns_prefix get_mpm_server_ips
syn keyword borgBuiltin get_mpm_version get_num_tasks get_task_name
syn keyword borgBuiltin mk_extra_argv mkargs mkpath_exports objectname
syn keyword borgBuiltin package_dir packagename pp_fetch_args
syn keyword borgBuiltin pp_fetch_backends pp_fetch_shardinfo
syn keyword borgBuiltin reduce_with_replicas shellescape use_minicluster
syn keyword borgBuiltin username

if version >= 508 || !exists("did_borg_syn_inits")
  if version <= 508
    let did_borg_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  HiLink borgKeyword            gclKeyword
  HiLink borgCfgSection         gclSection
  HiLink borgCfgAttribute       gclAttribute
  HiLink borgBuiltin            gclBuiltin

  delcommand HiLink
endif

let b:current_syntax = "borg"

" vim: ts=8
