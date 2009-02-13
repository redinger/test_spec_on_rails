module Test::Spec::Rails::ShouldCascadeDeletes
  def it_should_cascade_deletes(*one_or_more_associations)
    model_name = self.model_class_under_test
  
    one_or_more_associations.each do |option|
      option.each_pair do |association, value|
        it "should cascade deletes on #{association.to_s.humanize.downcase}" do
          association_under_test = model_name.reflect_on_association(association)
          assert_not_nil association_under_test, "#{association} association does not exist"
          assert_equal value, association_under_test.options[:dependent], "Expected association #{association} to cascade deletes as #{value}, but it didn't"
        end
      end
    end
  end
  
  def model_class_under_test
    name.constantize
  end
end

Test::Unit::TestCase.send(:extend, Test::Spec::Rails::ShouldCascadeDeletes)