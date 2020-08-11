def setup_option(conf)
  conf.cc.flags[0].delete("/Zi") unless ENV['CFLAGS']
  conf.cxx.flags[0].delete("/Zi") unless ENV['CFLAGS'] || ENV['CXXFLAGS']
  conf.linker.flags << "/DEBUG:NONE" unless ENV['LDFLAGS']
end

MRuby::Build.new('full-debug') do |conf|
  toolchain :visualcpp
  enable_debug

  # include all core GEMs
  conf.gembox 'full-core'
  conf.cc.defines += %w(MRB_GC_STRESS MRB_ENABLE_DEBUG_HOOK)
  setup_option(conf)

  conf.enable_test
end

MRuby::Build.new do |conf|
  toolchain :visualcpp

  # include all core GEMs
  conf.gembox 'full-core'
  conf.compilers.each do |c|
    c.defines += %w(MRB_GC_FIXED_ARENA)
  end
  setup_option(conf)
  conf.enable_bintest
  conf.enable_test
end
