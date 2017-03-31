class AssetsController < SimpleController
  self.permitted_params = %w(name symbol category expense_ratio exchange)
end
