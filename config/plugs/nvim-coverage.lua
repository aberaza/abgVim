local status, coverage = pcall(require, "coverage")
if (not status) then return end

coverage.setup()
