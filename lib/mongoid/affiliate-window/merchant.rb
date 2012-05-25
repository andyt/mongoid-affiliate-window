module Mongoid
  module AffiliateWindow
    module Merchant

      def self.included(base)
        base.instance_eval do
          field :merchant_id, type: Integer
          field :name, type: String
          field :label, type: String
          field :description, type: String
          field :url, type: String

          key :label, unique: true
          index :name, unique: true

          validates_uniqueness_of :merchant_id
          validates_uniqueness_of :name
          validates_uniqueness_of :label
        end
        base.extend ClassMethods
      end

      module ClassMethods

        def new_from_csv(row)
          new(
            :merchant_id => row[:merchant_id].to_i,
            :name => row[:merchant_name],
            :label => row[:merchant_name].parameterize,
            :description => row[:description],
            :url => row[:display_url]
          )
        end

      end

      # I should decouple this dependency.
      def click_url
        "http://www.awin1.com/awclick.php?mid=%s&id=%s" % [merchant_id, ::AffiliateWindow.account.user]
      end

      def to_param
        label
      end

    end
  end
end