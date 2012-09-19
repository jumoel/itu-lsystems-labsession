class LToLogo
	attr_accessor :grammar, :axiom, :angle, :drawlength


	def initialize(grammar,axiom, angle, start, drawlength = 5)
		@grammar = grammar
		@axiom = axiom

		@angle = angle
		@drawlength = drawlength
		@start = start

		@translations = {
			"F" => "Forward #{@drawlength}\n",
			"f" => "PU\nFD #{@drawlength}\nPD\n",
			"+" => "LT #{@angle}\n",
			"-" => "RT #{@angle}\n",
			"[" => "Make \"headings FirstPut Heading :headings\n" +
				"Make \"positions FirstPut Position :positions\n",
			"]" => "SetHeading First :headings\nMake \"headings ButFirst :headings\n" +
				"SetPosition First :positions\nMake \"positions ButFirst :positions\n"
		}
	end

	def expand(iterations)
		iterations = 0 if iterations < 0

		output = @axiom
		iterations.times do
			parts = output.split("")

			output = ""
			
			parts.each do |p|
				if @grammar[p].nil?
					output += p
				else
					output += @grammar[p]
				end
			end
		end

		@expanded_system = output
	end

	# requires a deterministic grammar from L-system to Logo
	def compile(lsystem = @expanded_system)
		parts = lsystem.split("")

		output = ""
		parts.each do |p|
			translation = @translations[p]

			if translation.nil?
				raise "Unrecognized part '#{p}'."
			else
				output += translation
			end
		end

		"HideTurtle\n" +
		"ClearScreen\n" +
		"PU\nSetPosition #{@start}\nPD\n" +
		"Make \"positions []\n" +
		"Make \"headings []\n" + output
	end
end

lsystems = {
	"quadratic-koch-island" => {
		:grammar => {
			"F" => "F-F+F+FF-F-F+F"
		},
		:axiom => "F+F+F+F",
		:angle => 90,
		:start => "[150 -250]"
	},
	"windy-tree" => {
		:grammar => {
	       		"F" => "F[-F]F[+F]F[F]",
		},
		:axiom => "F",
		:angle => 30,
		:start => "[0 -300]",
	}
}

qki = lsystems["quadratic-koch-island"]
wtree = lsystems["windy-tree"]

a = qki

iterations = 3

l = LToLogo.new(a[:grammar], a[:axiom], a[:angle], a[:start])
expanded = l.expand(iterations)
puts l.compile()
