module Mongoid
  module AffiliateWindow
    module Merchant

      def self.included(base)
        base.instance_eval do
          field :id, type: Integer
          field :name, type: String
          field :label, type: String
          field :description, type: String

          key :label, unique: true
          index :name, unique: true

          validates_uniqueness_of :id
          validates_uniqueness_of :name
          validates_uniqueness_of :label
        end
      end

      # I should decouple this dependency.
      def click_url
        "http://www.awin1.com/awclick.php?mid=%s&id=%s" % [id, ::AffiliateWindow.account.user]
      end

    end
  end
end