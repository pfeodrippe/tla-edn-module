------------- CONFIG EdnTests ---------

===================

-------------------------------- MODULE EdnTests --------------------------------

EXTENDS Edn, Integers, Sequences, TLC, TLCExt

ASSUME(AssertEq(ToEdn({}), "#{}"))
ASSUME(AssertEq(ToEdn({3, 2, 1}), "#{1 3 2}"))
ASSUME(AssertEq(ToEdn([a |-> TRUE, b |-> FALSE]), "{\"a\" true, \"b\" false}"))

ASSUME(AssertEq(ToEdn([a |-> {<<1, 2>>}, b |-> [c |-> 3]]), "{\"a\" #{[1 2]}, \"b\" {\"c\" 3}}"))

RoundTrip ==
    LET output == <<[a |-> 3], 2, <<<<1, 2>>, "look">>, <<<<<<[b |-> [c |-> <<4, 5, 6>>]]>>>>>>>>
    IN
       /\ EdnSerialize("test.edn", output)
       /\ output = EdnDeserialize("test.edn")
ASSUME(RoundTrip)

=============================================================================
