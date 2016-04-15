ValidatesTimeliness.setup do |config|
  config.default_timezone = 'Berlin'
  config.restriction_shorthand_symbols.update(
    now: lambda { Time.current },
    today: lambda { Date.current }
  )
  config.use_plugin_parser = true
  config.parser.add_formats(:datetime, 'dd.mm.yy hh:nn:ss')
  config.parser.add_formats(:datetime, 'dd.mm.yy hh:nn')
  config.parser.ambiguous_year_threshold = 60
end
