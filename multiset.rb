# multiset.rb

# https://github.com/maraigue/multiset/blob/master/lib/multiset.rb

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



class Mset
	include Enumerable

	attr_accessor :a_hash

	def initialize(**args)
		@a_hash = Hash.new

		if (args.count > 0) 
			args.each {|k, v| 
				validate!(v)
				a_hash[k] = v #overwrites duplicate keys, expected hash behavior 
			}
		end
	end #init


	def each 
		yield a_hash
	end


	def validate!(value)
		if (value < 1) 
				ArgumentError.new("All values in hash need to be positive")
		end

		if (!value.respond_to?(:to_i)) 
			ArgumentError.new("All values in hash need to be integers")
		end
	end #validate


	def self.[](*list)	
		puts 'in self'
    initialize(list)
	end


 	def [](*args)
 	  puts 'in brackets'	
 		if (args.class == Hash) #a hash
 			puts 'a hash'
 			initialize(args)
 		elsif (args.count == 1)	#a key
 			count_for_key(args[0])
 		else #a set 
			args.each {|k, v|
				if(a_hash.has_key?(k))
					a_hash[k] += 1
				else 
					a_hash[k] = 1
				end
			}
			a_hash
 		end
 	end 		


	def count_for_key(key)
		if(a_hash.has_key?(key.to_sym))
			a_hash[key.to_sym]
		else nil
		end
	end #count for key


	def add_two(a, b)
		puts a.class
		puts b.class
		if (a.class == Hash && b.class == Hash)
			puts 'two hashes'
			a.each {|k, v|
				b[k] += v
			}
			puts b
		end
	end #add two

end #class Mset


=begin
h = {a:23, b:2, c: 9}
m = Mset.new(h)
puts m[:a]
puts m[:foo]
puts m.count_for_key('3')
puts m.count_for_key('b')
n = Mset.new(foo:12, bar:18)
puts n[:bar] 
=end
#n = Mset[ham:13, ram:22]
a = Mset.new[1,3,3,3,4,5,5]
puts a
#b = Mset.new([3 => 12, 4 => 1])	
#c = Mset.new
#c.add_two(a, b)
#puts c
#puts c