# frozen_string_literal: true

RSpec.shared_examples "disable modification" do |resource_class|
  describe "#valid_action?" do
    context "when name is index" do
      specify { expect(subject.valid_action?("index", resource_class)).to eq(true) }
    end

    context "when name is create" do
      specify { expect(subject.valid_action?("create", resource_class)).to eq(false) }
    end

    context "when name is new" do
      specify { expect(subject.valid_action?("new", resource_class)).to eq(false) }
    end

    context "when name is edit" do
      specify { expect(subject.valid_action?("edit", resource_class)).to eq(false) }
    end

    context "when name is show" do
      specify { expect(subject.valid_action?("show", resource_class)).to eq(true) }
    end

    context "when name is update" do
      specify { expect(subject.valid_action?("update", resource_class)).to eq(false) }
    end

    context "when name is destroy" do
      specify { expect(subject.valid_action?("destroy", resource_class)).to eq(false) }
    end
  end
end
