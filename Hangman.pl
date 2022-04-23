#list of words. to add more words user can append in it. 
my @list_of_words = ("computer","radio","calculator","teacher","bureau","police","geometry","president","subject","country","enviroment","classroom","animals","province","month","politics","puzzle","instrument","kitchen","language","vampire","ghost","solution","service","software","virus25","security","phonenumber","expert","website","agreement","support","compatibility","advanced","search","triathlon","immediately","encyclopedia","endurance","distance","nature","history","organization","international","championship","government","popularity","thousand","feature","wetsuit","fitness","legendary","variation","equal","approximately","segment","priority","physics","branche","science","mathematics","lightning","dispersion","accelerator","detector","terminology","design","operation","foundation","application","prediction","reference","measurement","concept","perspective","overview","position","airplane","symmetry","dimension","toxic","algebra","illustration","classic","verification","citation","unusual","resource","analysis","license","comedy","screenplay","production","release","emphasis","director","trademark","vehicle","aircraft","experiment");
# array for gusesing the word
my @hangman = ();
# array for wrong guesses
my @misses = ();
#no of wrong guesses out of 8;
my $tries_taken = 0;
#to cintinue paly of not
my $wanna_play_again = 1;
#no. of wins
my $lyf_save = 0;
#total games played
my $total_games = 0;
&instructions();
#main while loop of program
while($wanna_play_again == 1)
{
    #calling the driver sub routine
    &driver_sub();
    #keeping record of no of games played
    $total_games++;
    #again making the arrays empty
    @misses = ();
    # reassigning the lifes /chances 
    $tries_taken = 0;
    $wanna_play_again = 0;
    print "\n";
    #printing the stats of player.
    print "Your stats:\tYou saved $lyf_save lives out of $total_games.\n\n";
    # choice for continuing or not
    print "Hey!! wanna save more lives!!\nEnter 1 for continue and 0 for exiting.\n";
    print "Your choice (either 1 OR 0): ";
    #taking input
    $wanna_play_again = <STDIN>;
    if( $wanna_play_again == 1)
    {
        print "\nLet's save more peoples.\nlessgooooo\n";
    }
    elsif( $wanna_play_again == 0)
    {
        print "You choose to exit. Hav a nice day.\n";
    }
    else
    {
        print "Wrong input!! exiting program!!\n";
        return;
    }
} 
#prints some instuctions
sub instructions
{
    print "\t\t ***********Welcome to Hangman********** \n";
    print "Your motive is to save people's life by guessing the word.\n";
    print "Remember person's on the line.\nYou can only afford atmost 8 chances. Good luck champ. Save as many lives.\n";
    print "\n\n";
}
# sub routines for each game played.
sub driver_sub()
{
    #getting a random word from the list of words.
    my $word = give_random_word();
    $word = lc($word);
    my $len_word = length($word);

    # print $word;
    #making the gueesses spaces ready
    @hangman = &ini_empty_array($len_word);
    print "Your Word until now: ";
    &print_array(@hangman);

    my $solvedORnot = 1;
    #running until person dies or user guesses the word
    while( $solvedORnot )
    {
        &hangman_display($tries_taken);
        if( $tries_taken == 8)
        {
            print "Bad luck buddy, You couldn't save life of person.\nYou lose.\n";
            return;
        }
        print "\nEnter a letter( A alpha numeric Character); ";
        my $try = <STDIN>;
        chomp $try;
        my $check = check_correct_input($try);
        if($check == 0)
        {
            print "user inputed more than one charactors.\n";
            print "taken 1st char of input as \n";
            $try = substr($try, 0, 1);
        }
        elsif($check == 2)
        {
            print "user inputed uppercase char. So converted it into lowercase and accept it.\n";
        }
        $try = lc $try;
        &check_guess_letter($word, $try);
        $solvedORnot = &win_lose($word);

        print  "Guessesd Word: $try\n";
        print "Your Word until now: ";
        &print_array(@hangman); 
        print  "Wrong guesses so far: ";
        &print_array(@misses);
        print("\n");
    }
    print "Yaaay!! You saved a man's life!!\nYou won.";
    $lyf_save++;
}
#to check whether person win or lose
sub win_lose
{
    my($word) = @_;
    for( my $i = 0; $i < length($word); $i++)
    {
        my $letter = substr($word, $i, 1);
        if($letter ne $hangman[$i])
        {
            return 1;
        }
    }
    return 0;
}
#to check guessed letter present in the word or not
sub check_guess_letter
{
    my ($word, $try) = @_;
    #if char alrady guessed anf inputed again 
    for( my $i=0; $i< length($word); $i++)
    {
        if($try eq $hangman[$i])
        {
            print "Sorry!! You already Guessed!!. Enter other than $try\n";
            return;
        }
    }
    my $misses_size = @misses;
    #again gueses the wrong char inputed a moment ago
    for(my $i = 0; $i < $misses_size ;$i++)
    {
        if($try eq $misses[$i])
        {
            print "Again! Bad Guess! You guess it a moment ago and was wrong.\nEnter another one.\n";
            $tries_taken++;
            return;
        }
    }
    my $letter_pos = -1;
    #inputed a wrong char
    $letter_pos = index($word, $try);
    if($letter_pos == -1)
    {
        print "Bad Guess Buddy!! Try again!\n";
        push @misses, $try;
        $tries_taken++;
        return;
    }
    #inptued correct char
    for( my $i=0; $i< length($word); $i++)
    {
        my $letter = substr($word, $i, 1);
        if($try eq $letter)
        {
            $hangman[$i] = $letter;
        }
    }
}
# to check whether the user has inputed in correct formst or not
sub check_correct_input
{
    my ($str) = @_;
    my $le = length($str);
    #if char more than 1 inputed
    if($le != 1)
    {
        return 0;
    }
    if ($str =~ /^[a-z]+$/)
    {
        return 1;
    }
    #if inputed upper case
    elsif ($str =~ /^[A-Z]+$/)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}
# to print the array
sub print_array
{
    my(@to_print) = @_;
    my $size = @to_print;
    #printing the arrat
    for(my $i = 0; $i < $size; $i++)
    {
        print "$to_print[$i] ";
    }
    print "\n";
}
#to initialize the array to '_'
sub ini_empty_array
{
    my($l) = @_;
    my @final = ();
    #initilzing to _
    for(my $i = 0; $i < $l; $i++)
    {
        push @final, '_';
    }
    return @final;
}
# to get random strig from the list of words.
sub give_random_word
{
    my $length = @list_of_words;
    #getting radom word for the lsit
    my $choosen_word = @list_of_words[int(rand($length))];
    return $choosen_word;
}
# to print the situation if hang man during the game.
sub hangman_display
{
    my ($max) = @_;
    print "Situation of person so far:\n";
    if( $max == 0)
    {
        print "   \t +------+\n";
        print "   \t |  \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "\t==========\n";
        
    }
    elsif( $max == 1)
    {
        print "   \t +------+\n";
        print "   \t |  \t|\n";
        print "   \t |  \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "\t==========\n";
    }
    elsif( $max == 2)
    {
        print "   \t +------+\n";
        print "   \t |  \t|\n";
        print "   \t |  \t|\n";
        print "   \t O  \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "\t==========\n";
    }
    elsif( $max == 3)
    {
        print "   \t +------+\n";
        print "   \t |  \t|\n";
        print "   \t |  \t|\n";
        print "   \t O  \t|\n";
        print "   \t |  \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "\t==========\n";
    }
    elsif( $max == 4)
    {
        print "   \t +------+\n";
        print "   \t |  \t|\n";
        print "   \t |  \t|\n";
        print "   \t O  \t|\n";
        print "   \t/|  \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "\t==========\n";

    }
    elsif( $max == 5)
    {
        print "   \t +------+\n";
        print "   \t |  \t|\n";
        print "   \t |  \t|\n";
        print "   \t O  \t|\n";
        print "   \t/|\\ \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "\t==========\n";
    }
    elsif( $max == 6)
    {
        print "   \t +------+\n";
        print "   \t |  \t|\n";
        print "   \t |  \t|\n";
        print "   \t O  \t|\n";
        print "   \t/|\\ \t|\n";
        print "   \t |  \t|\n";
        print "   \t    \t|\n";
        print "   \t    \t|\n";
        print "\t==========\n";
    }
    elsif( $max == 7)
    {
        print "   \t +------+\n";
        print "   \t |  \t|\n";
        print "   \t |  \t|\n";
        print "   \t O  \t|\n";
        print "   \t/|\\ \t|\n";
        print "   \t |  \t|\n";
        print "   \t/   \t|\n";
        print "   \t    \t|\n";
        print "\t==========\n";
    }
    else
    {
        print "   \t +------+\n";
        print "   \t |  \t|\n";
        print "   \t |  \t|\n";
        print "   \t O  \t|\n";
        print "   \t/|\\ \t|\n";
        print "   \t |  \t|\n";
        print "   \t/ \\ \t|\n";
        print "   \t    \t|\n";
        print "\t==========\n";
    }
}