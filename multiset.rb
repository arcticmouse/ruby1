# multiset.rb

# questions : 
# the each for enumerate
# what is yield
# better to use super in initialize?
# add Hash methods to my class (would super have done that)?
# add_two cant get value via key 
# verify to_h works because of Mset < Hash
# why doesnt a_hash.sort_by {|k, v| k} work


# https://github.com/maraigue/multiset/blob/master/lib/multiset.rb
# https://www.rubyguides.com/2018/06/rubys-method-arguments/
# https://medium.com/@ethan.reid.roberts/rubys-anonymous-eigenclass-putting-the-ei-in-team-ebc1e8f8d668
# https://medium.com/@amliving/how-i-think-about-rubys-enumerable-38219350696
# https://medium.com/@amliving/recreating-rubys-enumerable-7a8b898b8482
# https://stackoverflow.com/questions/4370960/what-is-attr-accessor-in-ruby

## class MSet. initialized with a hash
## hash to store members (keys) and their counts (values)
## ArgumentError if val is less than 1 or not to_i
## returns count for a given member OR nil if member not exists
## be initialized with _any_ Enumerable, in which case it traverses the Enumerable, adding 1 for every member it finds.
## besides Mset.new, you can construct a multiset with the [] Mset class method. ; m = Mset[ham:13, ram:22]
# add two multisets
## to_h : return a new hash with the same content as the MSet
## to_a : create element for each element of Mset times it's count
# to_set : returns a new set whose members are the members of the Mset. The count information isn't preserved in any way, of course, so if you convert it back to a multiset you only get the same thing if all the multiset's counts happened to be 1.
## equality method == ; Mset.new(m.to_a) == m is true
## If a is a sortable list (lists may or may not be sortable depending on whether their membership has an inter-compatible <=>):
## an each method and Multiset should include Enumerable.
## The member? and include? methods should return a boolean to indicate membership
# delete method should remove a member and return the value the member had
# Assignment should work; assignment to zero is valid and is the equivalent of deleting. Assignment to a negative number or something without a to_i should raise an ArgumentError.
# size and count should work and return the sum of the values of the multiset.



puts "hello"


class Mset < Hash

	include Enumerable
	attr_accessor :a_hash


	def initialize(args)
		@a_hash = Hash.new

		if(defined?(args))
			puts "in init"
			#puts "args is #{args}"
			#puts args.class

			if(args.class == Hash)
				args.each {|k, v| 
					validate!(v)
					a_hash[k] = v #overwrites duplicate keys, expected hash behavior 
				}
				puts a_hash
			end

			if(args.class == Array)
					puts args.count
					#if(args.count == 1)
					#	puts "it is one"
					#end
					args.each {|k|
						#puts "k is #{k}"
						if(a_hash.has_key?(k))
							a_hash[k] += 1
						else 
							a_hash[k] = 1
						end
					}
					puts a_hash
			end

		end #if defined
	end #initialize

	#https://www.tutorialspoint.com/ruby/ruby_blocks.htm
	def each(&block)
		@a_hash.each(&block)
		self
	end # each


	def validate!(value)
		if(value < 1) 
				ArgumentError.new("All values in hash need to be positive")
		end

		if(!value.respond_to?(:to_i)) 
			ArgumentError.new("All values in hash need to be integers")
		end
	end #validate


	def self.[](args)
		puts "in self"
		#puts args.class
		#puts args.count
		#puts "a hash is"
		#puts @a_hash
		if(defined?(args) && args.count > 0)
			#puts "args is #{args}"
			self.new(args)
		end
	end # self.[]


	def [](key)
		puts "in brackets"
		
		if(key.is_a?String)
			key = key.to_sym
		elsif(key.is_a?Numeric)
			key = key.to_s.to_sym
		end

		#puts key
		#puts key.class
		#puts a_hash
		#puts a_hash[key]

		if(a_hash.has_key?(key))
			#puts a_hash[key]
			a_hash[key]
		else 
			#puts 'it is nil'
			#puts a_hash
			#puts key
			nil
		end
	end #[]


	def self.add_two(a, b)
		#puts a.class
		#puts a
		#puts b.class
		#puts b

		if(a.class != Mset)
			a = new(a)
		end 	
		if(b.class != Mset)
			b = new(b)
		end

		puts "merging these two"
		puts a.count
		puts a.class
		puts b.count
		puts b.class
=begin
		if(a.count > b.count)
			long = a
			short = b
		else 
			long = b
			short = a
		end	
=end
	puts "b three is  #{b[3]}"
	puts b[3]

		a.each{|k, v|
			puts "#{k} and #{v}"
			if(b.has_key?(k))
				puts "it has the key"
				b[k] += v
			else 
				puts "it does not have the key"
				b[k] = 1
			end	
		}

		return a
	end #add two


	def to_h
		puts 'making a hash'
		#puts a_hash.class
		a_hash 
	end #to_h	


	def to_a
		puts "to array with keys same amount as their values"

		arr = Array.new

		a_hash.each_with_index{ |(k, v), i|
			q = 0
			validate!(v)
			while q < v do
				arr.push(k.to_sym)
				q += 1
			end
		}
		puts arr.class
		arr
	end #to_a


	def sort
		#nothing defined so sorting by key
		puts "in sort"
		#a_hash.sort_by {|k, v| k}
		a_hash.sort
	end	


	def include?(arg)
		puts "in include"
		puts arg
		puts a_hash
		if(arg.class == Symbol || arg.count == 1)
			a_hash.has_key?(arg) || a_hash.has_key?(arg.to_sym)
		else false
		end	
	end

	def include(arg)
		include?(arg)
	end	

	def member?(arg)
		include?(arg)
	end	

	def member(arg)
		member?(arg)
	end


	def delete(arg)
		puts "in delete"
		if(arg.class == Symbol || arg.count == 1)
			if(a_hash.has_key?(arg))
				a_hash.reject{ |k, v| k == arg}
				a_hash
			else nil
			end
		else nil
		end	
	end	


	# https://stackoverflow.com/questions/1931604/whats-the-right-way-to-implement-equality-in-ruby
	def == (other)
		other.class == self.class && other.state == state
	end


	protected

  def state
    self.instance_variables.map { |variable| self.instance_variable_get variable }
  end

end #class Mset



h = {b:2, q:32, c: 9, a:23}
m = Mset.new(h)
=begin
puts m[:a]
puts m[:foo]
n = Mset.new(foo:12, bar:18)
puts n[:bar] 

q = Mset[ham:13, ram:22]

#a = [1,3,3,3,4,5,5]
#b = Mset.new({3 => 12, 4 => 1})
#c = Mset.add_two(a, b)
#puts c

=begin
puts m.class
a_new_hash = m.to_h
puts a_new_hash.class
puts a_new_hash

Mset.new({b:3,x:2}).to_a 

puts Mset.new(m.to_a) == m
puts Mset.new(m.to_h) == m
puts Mset.new(h).to_h == h
puts Mset.new(m.to_a).sort == m.sort

puts m.include?(:b)
puts m.member?(:c)
puts m.include(:foo)
=end
puts m.delete(:c)
puts m.include?(:c)
puts m.delete(:c)