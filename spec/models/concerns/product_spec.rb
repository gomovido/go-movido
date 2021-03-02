shared_examples "product" do
  it { is_expected.to have_many(:subscriptions) }
end
