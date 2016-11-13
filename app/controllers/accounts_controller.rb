class AccountsController < SimpleController
  self.permitted_params = %w(name account_number institution)
end
