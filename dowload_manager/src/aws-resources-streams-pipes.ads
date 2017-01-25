pragma Ada_2012;
with AWS.Resources.Streams.Memory;
with GNAT.Semaphores;
with System;
with Ada.Finalization;

package AWS.Resources.Streams.Pipes is
   use AWS.Resources.Streams.Memory;
   type Stream_Type is new Streams.Memory.Stream_Type with private;


   procedure Append
     (Resource : in out Stream_Type;
      Buffer   : Stream_Element_Array;
      Trim     : Boolean := False);
   --  Append Buffer into the memory stream

   procedure Append
     (Resource : in out Stream_Type;
      Buffer   : Stream_Element_Access);
   --  Append static data pointed to Buffer into the memory stream as is.
   --  The stream will free the memory on close.

   procedure Append
     (Resource : in out Stream_Type;
      Buffer   : Buffer_Access);
   --  Append static data pointed to Buffer into the memory stream as is.
   --  The stream would not try to free the memory on close.

   overriding procedure Read
     (Resource : in out Stream_Type;
      Buffer   : out Stream_Element_Array;
      Last     : out Stream_Element_Offset);
   --  Returns a chunck of data in Buffer, Last point to the last element
   --  returned in Buffer.

   overriding function End_Of_File (Resource : Stream_Type) return Boolean;
   --  Returns True if the end of the memory stream has been reached

   procedure Clear (Resource : in out Stream_Type) with Inline;
   --  Delete all data from memory stream

   overriding procedure Reset (Resource : in out Stream_Type) is null;
   --  Reset the streaming data to the first position

   overriding procedure Set_Index
     (Resource : in out Stream_Type;
      To       : Stream_Element_Offset) is null;
   --  Set the position in the stream, next Read will start at the position
   --  whose index is To.

   overriding function Size
     (Resource : Stream_Type) return Stream_Element_Offset is ( 0);
   --  Returns the number of bytes in the memory stream

   overriding procedure Close (Resource : in out Stream_Type);
   --  Close the memory stream. Release all memory associated with the stream

private

   type Stream_Type is new Streams.Memory.Stream_Type with record
      Guard : aliased GNAT.Semaphores.Binary_Semaphore (True, System.Default_Priority);
      Is_Open : Boolean := True;
   end record;


   type Lock_Type (Guard : not null access GNAT.Semaphores.Binary_Semaphore) is new
     Ada.Finalization.Limited_Controlled with null record with
       Unreferenced_Objects => True;
   procedure Initialize (Object : in out Lock_Type);
   procedure Finalize   (Object : in out Lock_Type);



end AWS.Resources.Streams.Pipes;
