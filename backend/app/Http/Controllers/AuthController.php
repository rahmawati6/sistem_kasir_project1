<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'username' => 'required',
            'password' => 'required',
        ]);

        $user = User::where('email', $request->username)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['message' => 'Username atau password salah'], 401);
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'Login berhasil',
            'user' => $user,
            'token' => $token
        ]);
    }

    public function resetPassword(Request $request)
    {
        $request->validate([
            'username' => 'required',
            'password' => 'required|min:6|confirmed',
        ]);

        $user = User::where('email', $request->username)->first();

        if (!$user) {
            return response()->json(['message' => 'Username tidak ditemukan'], 404);
        }

        $user->password = Hash::make($request->password);
        $user->tokens()->delete();
        $user->save();

        return response()->json(['message' => 'Password berhasil diperbarui']);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['message' => 'Logout berhasil']);
    }

    public function me(Request $request)
    {
        return response()->json($request->user());
    }
}
