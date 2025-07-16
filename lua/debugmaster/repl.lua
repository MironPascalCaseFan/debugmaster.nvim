local dap = require("dap")

---@class dm.Repl
---@field canvas dm.Canvas

---@class dm.Repl
local Repl = {}

function Repl.new()
  local self = {

  }
end

function Repl:evaluate(input)
  local s = assert(dap.session())
  ---@type dap.EvaluateArguments
  local args = { frameId = s.current_frame.id, context = "repl", expression = input }
  s:request("evaluate", args, function(err, res)
    ---@type dap.Variable
    local var = { name = input, value = res.result, variablesReference = res.variablesReference }
    canvas:push(VariableWidget.new(s, var))
  end)
end

return {
  Repl = Repl,
}
