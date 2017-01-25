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

--  with Ada.Text_IO;
--  with AWS.Config.Set;
--  with AWS.Server;
--  with AWS.Services.Download;
--  with AWS.Services.Dispatchers.URI;
with GNAT.Memory_Dump;
procedure Download_Manager.Main is

--     use Ada;
--     use Ada.Text_IO;
   use AWS;
   S : AWS.Resources.Streams.Memory.Stream_Type;
   Buffer : Stream_Element_Array (1 .. 2);
   Last   : Stream_Element_Offset;
begin
   S.Append (Stream_Element_Array'(1, 2,3, 4));

   S.Read (Buffer, Last );
   GNAT.Memory_Dump.Dump (Buffer'Address, Natural (Last));

   S.Append (Stream_Element_Array'(5, 6, 7, 8));

   S.Read (Buffer, Last );
   GNAT.Memory_Dump.Dump (Buffer'Address, Natural (Last));
   S.Read (Buffer, Last );
   GNAT.Memory_Dump.Dump (Buffer'Address, Natural (Last));
   S.Read (Buffer, Last );
   GNAT.Memory_Dump.Dump (Buffer'Address, Natural (Last));
   S.Read (Buffer, Last );
   GNAT.Memory_Dump.Dump (Buffer'Address, Natural (Last));
   S.Read (Buffer, Last );
   GNAT.Memory_Dump.Dump (Buffer'Address, Natural (Last));


--     Create_Filename;
--
--     Config.Set.Server_Port (Conf, 8081);
--     Config.Set.Reuse_Address (Conf, True);
--
--     Services.Dispatchers.URI.Register   (URI, "/", CB'Unrestricted_Access);
--     Services.Dispatchers.URI.Register   (URI, "/download_file", CB'Unrestricted_Access);
--     Services.Dispatchers.URI.Register   (URI, "/stop", CB'Unrestricted_Access);
--     Services.Dispatchers.URI.Register   (URI, "/terminate", CB'Unrestricted_Access);
--
--     Text_IO.Put_Line ("Start download server...");
--
--     Services.Download.Start (URI, Handler, 1);
--
--     Text_IO.Put_Line ("Start main server...");
--
--     Server.Start (WS, Handler, Conf);
--
--     Text_IO.Put_Line ("Press Q to quit...");
--     Server.Wait (Server.Q_Key_Pressed);
--
--     Server.Shutdown (WS);
--     Services.Download.Stop;
end Download_Manager.Main;
