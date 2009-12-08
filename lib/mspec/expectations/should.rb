class Object
  NO_MATCHER_GIVEN = Object.new
  def should(matcher=NO_MATCHER_GIVEN)
    MSpec.expectation
    MSpec.actions :expectation, MSpec.current.state
    unless matcher.equal?(NO_MATCHER_GIVEN)
      SpecExpectation.matcher_paired!
      unless matcher.matches?(self)
        SpecExpectation.fail_with(*matcher.failure_message)
      end
    else
      SpecExpectation.should!
      SpecPositiveOperatorMatcher.new(self)
    end
  end

  def should_not(matcher=NO_MATCHER_GIVEN)
    MSpec.expectation
    MSpec.actions :expectation, MSpec.current.state
    unless matcher.equal?(NO_MATCHER_GIVEN)
      SpecExpectation.matcher_paired!
      if matcher.matches?(self)
        SpecExpectation.fail_with(*matcher.negative_failure_message)
      end
    else
      SpecExpectation.should!
      SpecNegativeOperatorMatcher.new(self)
    end
  end
end
