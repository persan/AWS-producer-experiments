------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2011-2012, AdaCore                     --
--                                                                          --
--  This is free software;  you can redistribute it  and/or modify it       --
--  under terms of the  GNU General Public License as published  by the     --
--  Free Software  Foundation;  either version 3,  or (at your option) any  --
--  later version.  This software is distributed in the hope  that it will  --
--  be useful, but WITHOUT ANY WARRANTY;  without even the implied warranty --
--  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU     --
--  General Public License for  more details.                               --
--                                                                          --
--  You should have  received  a copy of the GNU General  Public  License   --
--  distributed  with  this  software;   see  file COPYING3.  If not, go    --
--  to http://www.gnu.org/licenses for a complete copy of the license.      --
------------------------------------------------------------------------------

--  Compile this application, then run it with:
--
--  $ ./download_manager [<Mb>]
--
--  <Mb> is the size in Mb of the file to download, default to 100Mb
--

with Ada.Streams.Stream_IO;

with GNAT.Source_Info;
with AWS.Messages;
with AWS.MIME;
with AWS.Services.Download;
with Ada.Text_IO;
with GNAT.OS_Lib;
package  body Download_Manager is
   use Ada;
   use GNAT.Source_Info;
   --------
   -- CB --
   --------

   task type Stopper is

   end Stopper;
   task body Stopper is
   begin
      Ada.Text_IO.Put_Line (GNAT.Source_Info.Source_Location & ":" & Enclosing_Entity);
      delay 2.0;
      Ada.Text_IO.Put_Line (GNAT.Source_Info.Source_Location & ":" & Enclosing_Entity);
      GNAT.OS_Lib.OS_Exit (1);
   end Stopper;
   type Stopper_Access is access Stopper;
   Real_Stopper : Stopper_Access with Warnings => Off;

   function CB (Request : Status.Data) return Response.Data is
      URI    : constant String := Status.URI (Request);
      Stream : Resources.Streams.Stream_Access;
   begin
      if URI = "/" then
         return Response.File (MIME.Text_HTML, "main.html");

      elsif URI = "/download_file" then
         Stream := new Pump_Stream;
         Pump_Stream (Stream.all).Open;

         return Services.Download.Build (Request, Filename, Stream);

      elsif URI = "/stop" then
         return Response.Acknowledge (Messages.S200, "Terminating feed");
      elsif URI = "/terminate" then
             Real_Stopper := new Stopper;
         return Response.Acknowledge (Messages.S200, "Terminating");


      else
         return Response.Acknowledge (Messages.S404, "Not found");
      end if;
   end CB;

   ---------------------
   -- Create_Filename --
   ---------------------

   procedure Create_Filename is
      File : Stream_IO.File_Type;
   begin
      Ada.Text_IO.Put_Line (Source_Location & ":" & Enclosing_Entity);
      Stream_IO.Create (File, Stream_IO.Out_File, Filename);
      Stream_IO.Close (File);
   end Create_Filename;

   overriding
   function End_Of_File (Resource : Pump_Stream) return Boolean is
   begin
      return not Resource.Is_Open;
   end;

   procedure Real_Read
     (Resource : in out Pump_Stream;
      Buffer   : out Stream_Element_Array;
      Last     : out Stream_Element_Offset)  is
      pragma Unreferenced (Resource);
   begin
      Ada.Text_IO.Put_Line (GNAT.Source_Info.Source_Location & ":" & Enclosing_Entity);
      Last := Buffer'Last;
      Buffer := (others => 0);
      delay 0.3;
   end;

   overriding

   procedure Read
     (Resource : in out Pump_Stream;
      Buffer   : out Stream_Element_Array;
      Last     : out Stream_Element_Offset)  is
   begin
      Ada.Text_IO.Put_Line (GNAT.Source_Info.Source_Location & ":" & Enclosing_Entity);
      if not Resource.Is_Open then
         Last := Buffer'First - 1;
      else
         Resource.Real_Read (Buffer, Last);
      end if;
   end;
   procedure Open (S : in out Pump_Stream) is
   begin
      Ada.Text_IO.Put_Line (GNAT.Source_Info.Source_Location & ":" & Enclosing_Entity);
      S.Is_Open := True;
   end;

   overriding
   procedure Close (Resource : in out Pump_Stream)  is
   begin
      Ada.Text_IO.Put_Line (GNAT.Source_Info.Source_Location & ":" & Enclosing_Entity);
      Resource.Is_Open := False;
   end;


end Download_Manager;
