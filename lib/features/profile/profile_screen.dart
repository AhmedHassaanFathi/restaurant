import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/features/profile/cubit/profile_cubit/profile_cubit.dart';
import 'package:restaurant/features/profile/cubit/profile_cubit/profile_state.dart';
import 'package:restaurant/features/profile/widgt/build_profile.dart';
import 'package:restaurant/features/profile/widgt/image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Profile")),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileDataLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProfileDataSuccess) {
                    if (state.Userdata.isEmpty ||
                        state.Userdata[0].user == null) {
                      return const Center(child: Text("no data"));
                    }

                    var user = state.Userdata[0].user!;

                    return Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ProfileImagePicker(),
                          const SizedBox(height: 15),
                          Text(
                            user.name ?? "Ahmed Hassaan",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            user.email ?? "ahassaan@gmail.com",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    );
                  } else if (state is ProfileDataError) {
                    return Center(child: Text("Error ${state.message}"));
                  }

                  return const Center(child: Text("no data"));
                },
                listener: (context, state) {
                  if (state is ProfileDataError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error ${state.message}")),
                    );
                  }
                },
              ),
              buildProfileOptions(),
            ],
          ),
        ),
      ),
    );
  }
}
