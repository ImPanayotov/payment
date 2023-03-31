FactoryBot.define do
  factory :transaction do
    initialize_with { type.present? ? type.constantize.new : Transaction.new }

    uuid { SecureRandom.uuid }
    association :merchant
    association :customer
    status { 'approved' }
    amount_cents { 10_00 }

    trait :authorized do
      type { 'AuthorizeTransaction' }
    end

    trait :refunded do
      type { 'RefundTransaction' }
    end

    trait :charged do
      type { 'ChargeTransaction' }
    end

    trait :reversed do
      type { 'ReversalTransaction' }
    end
  end
end
