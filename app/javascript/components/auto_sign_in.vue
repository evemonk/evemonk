<template>
</template>

<script>
    import store from '../store';

    export default {
        data () {
            return {
            }
        },

        created () {
            let token = this.$route.params.token;
            store.commit('signInUserWithToken', token);
            this.$router.push('/profile');
        }
    }
</script>
