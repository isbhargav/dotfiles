P = function(args)
  print(vim.inspect(args))
  return args
end

RELOAD = function (...)
  return require('plenary.reload').reload_module(...)
end

R = function (name)
  RELOAD(name)
  return require(name)
end
