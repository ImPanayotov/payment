FactoryBot.define do
  factory :transaction do
    uuid { SecureRandom.uuid }
    association merchant, factory: :merchant
    association customer, factory: :customer
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
