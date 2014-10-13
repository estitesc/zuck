module Zuck
  class AdUser < RawFbObject
    read_only

    known_keys :id,
               :permissions,
               :role

    parent_object :ad_account
    list_path     :users
  end
end
