# multiset.rb

# questions : 
# the each for enumerate
# what is yield
# better to use super in initialize?
# add Hash methods to my class (would super have done that)?


# https://github.com/maraigue/multiset/blob/master/lib/multiset.rb
# https://www.rubyguides.com/2018/06/rubys-method-arguments/
# https://medium.com/@ethan.reid.roberts/rubys-anonymous-eigenclass-putting-the-ei-in-team-ebc1e8f8d668
# https://medium.com/@amliving/how-i-think-about-rubys-enumerable-38219350696
# https://medium.com/@amliving/recreating-rubys-enumerable-7a8b898b8482

## class MSet. initialized with a hash
## hash to store members (keys) and their counts (values)
## ArgumentError if val is less than 1 or not to_i
## returns count for a given member OR nil if member not exists
## be initialized with _any_ Enumerable, in which case it traverses the Enumerable, adding 1 for every member it finds.
## besides Mset.new, you can construct a multiset with the [] Mset class method. ; m = Mset[ham:13, ram:22]
# add two multisets
# to_h : return a new hash with the same content as the MSet
# to_a : create element for each element of Mset times it's count
# to_set : returns a new set whose members are the members of the Mset. The count information isn't preserved in any way, of course, so if you convert it back to a multiset you only get the same thing if all the multiset's counts happened to be 1.
# equality method == ; Mset.new(m.to_a) == m is true
# If a is a sortable list (lists may or may not be sortable depending on whether their membership has an inter-compatible <=>):
# an each method and Multiset should include Enumerable.
# The member? and include? methods should return a boolean to indicate membership
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
			puts "args is #{args}"
			puts args.class

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
						puts "k is #{k}"
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
		puts args.class
		puts args.count
		puts "a hash is"
		puts @a_hash
		if(defined?(args) && args.count > 0)
			puts "args is #{args}"
			self.new(args)
		end
	end # self.[]


	def [](*list)
		puts "in brackets"
		puts list.class
		puts list.count
		if(list.count == 1 && list.class == Array)
			count_for_key(list[0])
		end
	end #[]


	def count_for_key(key)
		puts "count for key"
		if(a_hash.has_key?(key))
			a_hash[key]
		else nil
		end
	end #count for key


	def do_the_addition(long, short)
		short.each{|k, v|
			if(long.has_key?(k))
				long[k] += v
			else 
				long[k] += 1
			end	
		}
		long
	end #do_the_addition


	def self.add_two(a, b)
		puts a.class
		puts a
		puts b.class
		puts b

		if(a.class != Mset)
			a = new(a)
		end 	
		if(b.class != Mset)
			b = new(b)
		end

		puts "merging these two"
		puts a.count
		#puts a.class
		puts b.count
		#puts b.class

		if(a.count > b.count)
			self.class.do_the_addition(a, b)
		else 
			self.class.do_the_addition(b, a)
		end	

	end #add two

end #class Mset



h = {a:23, b:2, c: 9}
m = Mset.new(h)
puts m[:a]
puts m[:foo]
puts m.count_for_key('3')
puts m.count_for_key('b')
n = Mset.new(foo:12, bar:18)
puts n[:bar] 

q = Mset[ham:13, ram:22]

a = [1,3,3,3,4,5,5]
b = Mset.new({3 => 12, 4 => 1})
c = Mset.add_two(a, b)
puts c