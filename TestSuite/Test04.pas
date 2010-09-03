unit Test04;

interface

{$ifndef ver110}

    {$ifndef ver90}
      {$ifndef ver100}
          {$define UseInt64}
      {$endif}
    {$endif}


    {$ifdef UseInt64}
    type TInt64 = Int64;
    {$else}
    type TInt64 = Comp;
    {$endif}

{$else}

    type TInt64 = TLargeInteger;

{$endif}

implementation

end.
