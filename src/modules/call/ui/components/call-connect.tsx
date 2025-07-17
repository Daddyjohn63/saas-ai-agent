'use client';

//import { LoaderIcon } from "lucide-react";
//import { useEffect, useState } from "react";
//import { useMutation } from "@tanstack/react-query";
// import {
//   Call,
//   CallingState,
//   StreamCall,
//   StreamVideo,
//   StreamVideoClient,
// } from "@stream-io/video-react-sdk";

//import { useTRPC } from "@/trpc/client";

//import "@stream-io/video-react-sdk/dist/css/styles.css";
//import { CallUI } from "./call-ui";

interface Props {
  meetingId: string;
  meetingName: string;
  userId: string;
  userName: string;
  userImage: string;
}

export const CallConnect = ({
  meetingId,
  meetingName,
  userId,
  userName,
  userImage
}: Props) => {
  return <div>Call connect</div>;
};
