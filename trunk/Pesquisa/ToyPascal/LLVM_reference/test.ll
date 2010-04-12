; Generated with toypasc
; program @sample0

; Declare the string constants as a global constants...
@.true_str = internal constant [5 x i8] c"true\00"
@.false_str = internal constant [6 x i8] c"false\00"
@.int_fmt = internal constant [3 x i8] c"%d\00"

; External declaration of functions
declare i32 @puts(i8 *)
declare i32 @putchar(i32)
declare i32 @printf(i8*, ...)

@x = global i32 0
@a = global i1 0
@b = global i1 0
@c = global i8 0

; Definition of main function
define i32 @main()
{
    ; [Template] store i32 50, i32* @x, align 4
    ;store i32 2 + 3 * 5 + 9, i32* @x
    %tmp = add i32 13, 50

    call i32 (i8* noalias , ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8* noalias , ...)*)( i8* getelementptr ([3 x i8]* @.int_fmt, i32 0, i32 0) noalias , i32 %tmp )

    call i32 @putchar( i32 10 )

    ret i32 0
}

