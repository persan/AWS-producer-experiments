package body AWS.Resources.Streams.Pipes is

   ------------
   -- Append --
   ------------

   procedure Append
     (Resource : in out Stream_Type;
      Buffer   : Stream_Element_Array;
      Trim     : Boolean := False)
   is
      Lock : Lock_Type (Resource.Guard'Access) with Warnings => Off;
   begin
      Streams.Memory.Stream_Type (Resource).Append (Buffer, Trim);
   end Append;

   ------------
   -- Append --
   ------------

   procedure Append
     (Resource : in out Stream_Type;
      Buffer   : Stream_Element_Access)
   is
      Lock : Lock_Type (Resource.Guard'Access) with Warnings => Off;
   begin
      Streams.Memory.Stream_Type (Resource).Append (Buffer);
   end Append;

   ------------
   -- Append --
   ------------

   procedure Append
     (Resource : in out Stream_Type;
      Buffer   : Buffer_Access)
   is
      Lock : Lock_Type (Resource.Guard'Access) with Warnings => Off;
   begin
      Streams.Memory.Stream_Type (Resource).Append (Buffer);
   end Append;

   ----------
   -- Read --
   ----------

   overriding procedure Read
     (Resource : in out Stream_Type;
      Buffer   : out Stream_Element_Array;
      Last     : out Stream_Element_Offset)
   is
      Lock : Lock_Type (Resource.Guard'Access) with Warnings => Off;
   begin
      Streams.Memory.Stream_Type (Resource).Read (Buffer, Last);
   end Read;

   -----------------
   -- End_Of_File --
   -----------------

   overriding function End_Of_File (Resource : Stream_Type) return Boolean is
   begin
      return Streams.Memory.Stream_Type (Resource).End_Of_File;
   end End_Of_File;

   -----------
   -- Clear --
   -----------

   procedure Clear (Resource : in out Stream_Type) is
      Lock : Lock_Type (Resource.Guard'Access) with Warnings => Off;
   begin
      Streams.Memory.Stream_Type (Resource).Clear;
 end Clear;

   -----------
   -- Close --
   -----------

   overriding procedure Close (Resource : in out Stream_Type) is
      Lock : Lock_Type (Resource.Guard'Access) with Warnings => Off;
   begin
      Streams.Memory.Stream_Type (Resource).Close;
   end Close;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Object : in out Lock_Type) is
   begin
      OBJECT.Guard.Seize;
   end Initialize;

   --------------
   -- Finalize --
   --------------

   procedure Finalize (Object : in out Lock_Type) is
   begin
      OBJECT.Guard.Release;
   end Finalize;

end AWS.Resources.Streams.Pipes;
