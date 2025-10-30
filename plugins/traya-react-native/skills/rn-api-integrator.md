---
name: rn-api-integrator
description: Comprehensive API integration workflow for React Native applications. Use this skill when connecting frontend components to backend APIs, implementing data fetching, handling authentication, and testing API interactions. Uses Postman MCP for API testing, Context7 for documentation, Serena for pattern analysis, and iOS Simulator/Mobile Device MCPs for integration verification.
---

# RN API Integrator

## Overview

This skill provides a complete API integration workflow for React Native applications. The process includes API discovery, testing with Postman, implementing service layers, integrating with React components, handling authentication, error management, and verifying end-to-end data flow on both platforms.

## Core Workflow

### Phase 1: API Discovery & Testing

**1. Analyze API Requirements**

Identify integration needs:
- API endpoints to integrate
- Authentication requirements (JWT, OAuth, API keys)
- Request/response formats
- Error handling requirements
- Rate limiting considerations
- Real-time data needs (WebSockets, polling)

**2. Test API with Postman MCP**

Use Postman MCP for API exploration:
```
mcp__postman__postman - Test API endpoints
```

Test scenarios:
- Valid requests with proper authentication
- Invalid requests (missing params, wrong types)
- Edge cases (empty data, large payloads)
- Error responses (4xx, 5xx)
- Rate limiting behavior
- Response time and performance

**3. Analyze Existing Patterns**

Use Serena MCP to find similar integrations:
```
mcp__serena__search_for_pattern - Search for API service patterns
mcp__serena__find_symbol - Find existing API services
mcp__serena__get_symbols_overview - Understand service structure
```

Focus on:
- API client configuration
- Request interceptors
- Error handling patterns
- Token management
- Response transformation
- Caching strategies

**4. Gather Documentation**

Use Context7 MCP for library docs:
```
mcp__context7__get-library-docs - Get axios/fetch documentation
```

Research:
- HTTP client library (axios, fetch)
- State management for server data (React Query, SWR)
- Authentication libraries
- Offline storage (AsyncStorage, MMKV)

### Phase 2: Service Layer Implementation

**5. Create API Client**

Setup HTTP client with interceptors:

```typescript
// services/api/client.ts
import axios from 'axios';
import Config from 'react-native-config';
import * as Keychain from 'react-native-keychain';

const apiClient = axios.create({
  baseURL: Config.API_URL,
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor - Add auth token
apiClient.interceptors.request.use(
  async (config) => {
    const credentials = await Keychain.getGenericPassword();
    if (credentials) {
      config.headers.Authorization = `Bearer ${credentials.password}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

// Response interceptor - Handle errors
apiClient.interceptors.response.use(
  (response) => response,
  async (error) => {
    if (error.response?.status === 401) {
      // Clear auth and redirect to login
      await Keychain.resetGenericPassword();
      // Navigate to login screen
    }
    return Promise.reject(error);
  }
);

export default apiClient;
```

**6. Implement Service Methods**

Create type-safe API service:

```typescript
// services/api/userService.ts
import apiClient from './client';

export interface User {
  id: string;
  name: string;
  email: string;
  avatar?: string;
}

export interface UpdateUserRequest {
  name?: string;
  avatar?: string;
}

export const userService = {
  getUser: async (userId: string): Promise<User> => {
    const response = await apiClient.get(`/users/${userId}`);
    return response.data;
  },

  updateUser: async (userId: string, data: UpdateUserRequest): Promise<User> => {
    const response = await apiClient.put(`/users/${userId}`, data);
    return response.data;
  },

  getCurrentUser: async (): Promise<User> => {
    const response = await apiClient.get('/users/me');
    return response.data;
  },
};
```

**7. Implement Error Handling**

Create error handling utilities:

```typescript
// services/api/errorHandler.ts
export interface ApiError {
  message: string;
  status?: number;
  code?: string;
}

export const handleApiError = (error: any): ApiError => {
  if (error.response) {
    // Server error response
    return {
      message: error.response.data?.message || 'Server error',
      status: error.response.status,
      code: error.response.data?.code,
    };
  } else if (error.request) {
    // Network error
    return {
      message: 'Network error. Please check your connection.',
      code: 'NETWORK_ERROR',
    };
  } else {
    // Unknown error
    return {
      message: error.message || 'An unexpected error occurred',
      code: 'UNKNOWN_ERROR',
    };
  }
};
```

### Phase 3: React Integration

**8. Implement React Query Integration**

Setup React Query for server state:

```typescript
// hooks/useUser.ts
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { userService, UpdateUserRequest } from '@/services/api/userService';

export const useUser = (userId: string) => {
  return useQuery({
    queryKey: ['user', userId],
    queryFn: () => userService.getUser(userId),
    staleTime: 5 * 60 * 1000, // 5 minutes
  });
};

export const useUpdateUser = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: ({ userId, data }: { userId: string; data: UpdateUserRequest }) =>
      userService.updateUser(userId, data),
    onSuccess: (updatedUser) => {
      queryClient.setQueryData(['user', updatedUser.id], updatedUser);
      queryClient.invalidateQueries({ queryKey: ['users'] });
    },
  });
};
```

**9. Integrate with Components**

Connect components to API:

```typescript
// screens/ProfileScreen.tsx
import React from 'react';
import { View, Text, StyleSheet, ActivityIndicator } from 'react-native';
import { useUser, useUpdateUser } from '@/hooks/useUser';

export const ProfileScreen = ({ route }) => {
  const { userId } = route.params;
  const { data: user, isLoading, error } = useUser(userId);
  const updateUser = useUpdateUser();

  if (isLoading) {
    return <ActivityIndicator />;
  }

  if (error) {
    return <ErrorMessage error={error} />;
  }

  const handleUpdate = async () => {
    try {
      await updateUser.mutateAsync({
        userId: user.id,
        data: { name: 'New Name' },
      });
    } catch (error) {
      // Error handling
    }
  };

  return (
    <View style={styles.container}>
      <Text>{user.name}</Text>
      <Button onPress={handleUpdate} title="Update" />
    </View>
  );
};
```

**10. Implement Offline Support**

Add offline persistence:

```typescript
// hooks/useOfflineUser.ts
import { useQuery } from '@tanstack/react-query';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { userService } from '@/services/api/userService';

export const useOfflineUser = (userId: string) => {
  return useQuery({
    queryKey: ['user', userId],
    queryFn: async () => {
      try {
        const user = await userService.getUser(userId);
        // Cache for offline
        await AsyncStorage.setItem(`user:${userId}`, JSON.stringify(user));
        return user;
      } catch (error) {
        // Load from cache if offline
        const cached = await AsyncStorage.getItem(`user:${userId}`);
        if (cached) {
          return JSON.parse(cached);
        }
        throw error;
      }
    },
  });
};
```

### Phase 4: Testing & Verification

**11. Test on iOS Simulator**

Use iOS Simulator MCP to verify:
```
mcp__ios-simulator__launch_app
mcp__ios-simulator__ui_describe_all
mcp__ios-simulator__take_screenshot
```

Test scenarios:
- Data loads correctly on screen
- Loading states display properly
- Error states handled gracefully
- Mutations update UI correctly
- Offline behavior works
- Pull-to-refresh functionality

**12. Test on Android Device**

Use Mobile Device MCP to verify:
```
mcp__mobile-device__mobile_launch_app
mcp__mobile-device__mobile_list_elements_on_screen
mcp__mobile-device__mobile_take_screenshot
```

Test scenarios:
- Same as iOS verification
- Network state changes handled
- Background/foreground transitions
- Data persistence verified

**13. Performance Testing**

Monitor API performance:
- Response times
- Network usage
- Memory impact
- Battery impact
- Cache effectiveness

### Phase 5: Optimization & Documentation

**14. Optimize Performance**

Improve API integration:
- Implement request caching
- Add request debouncing
- Use pagination for lists
- Implement optimistic updates
- Add request cancellation
- Minimize unnecessary requests

**15. Document Integration**

Create comprehensive docs:
- API endpoints used
- Authentication flow
- Error handling strategy
- Caching strategy
- Offline behavior
- Known limitations

## Best Practices

1. **Use React Query/SWR**: Better caching and state management
2. **Type All API Responses**: Complete TypeScript interfaces
3. **Handle All Error Cases**: Network, server, validation errors
4. **Implement Offline Support**: Cache data locally
5. **Secure Token Storage**: Use Keychain for tokens
6. **Add Request Interceptors**: Authentication, logging, error handling
7. **Test on Both Platforms**: iOS and Android verification
8. **Implement Loading States**: User feedback during requests
9. **Add Retry Logic**: Handle transient failures
10. **Monitor Performance**: Track response times and errors

## Completion Criteria

API integration is complete when:

1. ✅ All endpoints tested with Postman
2. ✅ Service layer is type-safe and tested
3. ✅ React Query/SWR integration complete
4. ✅ Components display data correctly
5. ✅ Loading and error states handled
6. ✅ Offline support implemented
7. ✅ Authentication flow works
8. ✅ Tested on both iOS and Android
9. ✅ Performance is optimized
10. ✅ Documentation is complete

Success is achieved when the API integration is robust, performant, and provides an excellent user experience even with poor network conditions.
