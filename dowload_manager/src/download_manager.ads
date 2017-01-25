with AWS.Response;
with AWS.Server;
with AWS.Services.Dispatchers.Linker;
with AWS.Services.Dispatchers.URI;
with AWS.Status;
with AWS.Config;
with AWS.Resources.Streams;
with Ada.Streams;
with AWS.Resources.Streams.Memory;
package  Download_Manager is

   use AWS;
   use Ada.Streams;
   function CB (Request : Status.Data) return Response.Data;
   procedure Create_Filename;

   Filename : constant String := "dm_file.data";
   URI      : Services.Dispatchers.URI.Handler;
   Handler  : Services.Dispatchers.Linker.Handler;
   Conf     : Config.Object := Config.Get_Current;
   WS       : Server.HTTP;
   type Pump_Stream is limited new  AWS.Resources.Streams.Memory.Stream_Type with private;


   procedure Open (S : in out Pump_Stream);
   overriding
   function End_Of_File (Resource : Pump_Stream) return Boolean;

   overriding
   procedure Read
     (Resource : in out Pump_Stream;
      Buffer   : out Stream_Element_Array;
      Last     : out Stream_Element_Offset);

   overriding
   procedure Close (Resource : in out Pump_Stream);

   overriding
   procedure Reset (Resource : in out Pump_Stream) is null;

   overriding
   procedure Set_Index
     (Resource : in out Pump_Stream;
      To       : Stream_Element_Offset) is null;


private
   not overriding
   procedure Real_Read
     (Resource : in out Pump_Stream;
      Buffer   : out Stream_Element_Array;
      Last     : out Stream_Element_Offset);
   type Pump_Stream is limited new  AWS.Resources.Streams.Memory.Stream_Type with record
      Is_Open : Boolean := False;
   end record;

end;
