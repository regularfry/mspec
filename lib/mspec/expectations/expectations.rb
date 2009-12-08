class SpecExpectationNotMetError < StandardError; end
class SpecExpectationNotFoundError < StandardError
  def message
    "No behavior expectation was found in the example"
  end
end

class SpecExpectation
  def self.verify_balance
    what = []
    what << "#{@pending_matchers} matcher#{@pending_matchers > 1 ? 's' : ''}" unless @pending_matchers == 0
    what << "#{@pending_shoulds} 'should'" unless @pending_shoulds == 0
    unless what.empty?
      fail_with("Expected 'should' and matchers to balance out", "but #{what.join(' and ')} did not")
    end
  end

  def self.matcher!
    @pending_matchers += 1
  end

  def self.matcher_paired!
    @pending_matchers -= 1
  end

  def self.should!
    @pending_shoulds += 1
  end

  def self.should_paired!
    @pending_shoulds -= 1
  end

  def self.cleanup
    @pending_shoulds = 0
    @pending_matchers = 0
  end
  cleanup

  def self.fail_with(expected, actual)
    if expected.to_s.size + actual.to_s.size > 80
      message = expected.to_s.chomp + "\n" + actual.to_s
    else
      message = expected.to_s + " " + actual.to_s
    end
    Kernel.raise SpecExpectationNotMetError, message
  end
end
